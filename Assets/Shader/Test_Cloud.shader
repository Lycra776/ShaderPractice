Shader "Custom/CloudWaveFadeDistort"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _WaveSpeed ("Wave Speed", Range(0.1, 10)) = 2.0
        _WaveAmplitude ("Wave Amplitude", Range(0.001, 0.1)) = 0.01
        _EdgeThreshold ("Edge Threshold", Range(0.01, 0.5)) = 0.1
        _FadeSpeed ("Fade Speed", Range(0.1, 5)) = 1.0
        _MinAlpha ("Minimum Alpha", Range(0, 1)) = 0.2
        _MaxAlpha ("Maximum Alpha", Range(0, 1)) = 1.0
        _DistortAmount ("Distort Amount", Range(0, 0.1)) = 0.02
        _DistortScale ("Distort Scale", Range(1, 20)) = 5.0
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="True" }
        LOD 100

        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _WaveSpeed;
            float _WaveAmplitude;
            float _EdgeThreshold;
            float _FadeSpeed;
            float _MinAlpha;
            float _MaxAlpha;
            float _DistortAmount;
            float _DistortScale;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // 计算扭曲效果
                float2 distort = float2(
                    sin(i.uv.y * _DistortScale + _Time.y * _WaveSpeed) * _DistortAmount,
                    cos(i.uv.x * _DistortScale + _Time.y * _WaveSpeed) * _DistortAmount
                );
                
                // 应用扭曲到UV
                float2 distortedUV = i.uv + distort;
                
                // 获取原始颜色
                fixed4 col = tex2D(_MainTex, distortedUV);
                
                // 如果是完全透明的像素，直接返回
                if (col.a < 0.1) return col;
                
                // 计算边缘强度 - 通过采样周围像素的alpha值
                float edge = 0;
                edge += tex2D(_MainTex, distortedUV + float2(0, _EdgeThreshold)).a;
                edge += tex2D(_MainTex, distortedUV - float2(0, _EdgeThreshold)).a;
                edge += tex2D(_MainTex, distortedUV + float2(_EdgeThreshold, 0)).a;
                edge += tex2D(_MainTex, distortedUV - float2(_EdgeThreshold, 0)).a;
                edge = 4 - edge; // 反转，使边缘值更高
                edge = saturate(edge); // 限制在0-1范围
                
                // 计算波浪偏移
                float wave = sin(_Time.y * _WaveSpeed + i.uv.x * 10) * _WaveAmplitude * edge;
                
                // 应用波浪偏移到UV坐标
                float2 finalUV = distortedUV + float2(0, wave);
                
                // 使用最终UV坐标采样
                fixed4 finalCol = tex2D(_MainTex, finalUV);
                
                // 计算渐隐渐现效果
                float fade = (sin(_Time.y * _FadeSpeed) + 1) / 2;
                // 将范围从[0,1]映射到[_MinAlpha, _MaxAlpha]
                fade = lerp(_MinAlpha, _MaxAlpha, fade);
                
                // 应用淡入淡出效果
                finalCol.a *= fade;
                
                return finalCol;
            }
            ENDCG
        }
    }
}