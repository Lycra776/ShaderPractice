Shader "AP01/L3/Lembert" {
    Properties {
    }
    SubShader {
            Tags {
                "RenderType"="Opaque"
            }
            Pass {
                Name "FORWARD"
                Tags {
                    "LightMode"="ForwardBase"
                }
                
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                #pragma multi_compile_fwdbase_fullshadows
                #pragma target 3.0
                
                
                struct VertexInput {
                    float4 vertex : POSITION;
                    float3 normal : NORMAL;
                };
                struct VertexOutput {
                    float4 pos : SV_POSITION;
                    float3 nDirWS : TEXCOORD0;
                };
                VertexOutput vert (VertexInput v) {
                    VertexOutput o = (VertexOutput)0;
                    o.pos = UnityObjectToClipPos( v.vertex );
                    o.nDirWS = UnityObjectToWorldNormal( v.normal);
                    return o;
                }


                float4 frag(VertexOutput i) : COLOR {
                    float3 nDir = i.nDirWS;
                    float3 lDir = _WorldSpaceLightPos0.xyz;
                    float nDot1 = dot(i.nDirWS,lDir);
                    float lambert = max(0.0,nDot1);
                    return float4(lambert,lambert,lambert,1.0);
                }
                ENDCG
            }
        }
        FallBack "Diffuse"
}
