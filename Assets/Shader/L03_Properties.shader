// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33755,y:33034,varname:node_3138,prsc:2|emission-4552-OUT;n:type:ShaderForge.SFN_Vector4Property,id:6829,x:32077,y:32838,ptovrint:False,ptlb:lightDir,ptin:_lightDir,varname:node_6829,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:1,v3:0,v4:0;n:type:ShaderForge.SFN_Normalize,id:4565,x:32266,y:32838,varname:node_4565,prsc:2|IN-6829-XYZ;n:type:ShaderForge.SFN_NormalVector,id:9981,x:32281,y:33008,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:3048,x:32486,y:32889,varname:node_3048,prsc:2,dt:0|A-4565-OUT,B-9981-OUT;n:type:ShaderForge.SFN_RemapRange,id:5703,x:32623,y:32919,varname:node_5703,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-3048-OUT;n:type:ShaderForge.SFN_Color,id:4500,x:32499,y:33189,ptovrint:False,ptlb:node_4500,ptin:_node_4500,varname:node_4500,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.7,c2:1,c3:0.7,c4:1;n:type:ShaderForge.SFN_Multiply,id:2606,x:32707,y:33189,varname:node_2606,prsc:2|A-5703-OUT,B-4500-RGB;n:type:ShaderForge.SFN_Slider,id:1339,x:32564,y:33360,ptovrint:False,ptlb:lightden,ptin:_lightden,varname:node_1339,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.6614141,max:1;n:type:ShaderForge.SFN_Multiply,id:4289,x:32952,y:33244,varname:node_4289,prsc:2|A-2606-OUT,B-1339-OUT;n:type:ShaderForge.SFN_TexCoord,id:8103,x:32798,y:33475,varname:node_8103,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Tex2d,id:3656,x:32973,y:33475,ptovrint:False,ptlb:node_3656,ptin:_node_3656,varname:node_3656,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6a5dcedef7e121e468bf55afed723d35,ntxv:0,isnm:False|UVIN-8103-UVOUT;n:type:ShaderForge.SFN_Multiply,id:9416,x:33164,y:33384,varname:node_9416,prsc:2|A-4289-OUT,B-3656-RGB;n:type:ShaderForge.SFN_SwitchProperty,id:4552,x:33455,y:33390,ptovrint:False,ptlb:node_4552,ptin:_node_4552,varname:node_4552,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-3656-RGB,B-9416-OUT;proporder:6829-4500-1339-3656-4552;pass:END;sub:END;*/

Shader "Shader Forge/L03_Properties" {
    Properties {
        _lightDir ("lightDir", Vector) = (0,1,0,0)
        _node_4500 ("node_4500", Color) = (0.7,1,0.7,1)
        _lightden ("lightden", Range(0, 1)) = 0.6614141
        _node_3656 ("node_3656", 2D) = "white" {}
        [MaterialToggle] _node_4552 ("node_4552", Float ) = 0
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
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_3656; uniform float4 _node_3656_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _lightDir)
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_4500)
                UNITY_DEFINE_INSTANCED_PROP( float, _lightden)
                UNITY_DEFINE_INSTANCED_PROP( fixed, _node_4552)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _node_3656_var = tex2D(_node_3656,TRANSFORM_TEX(i.uv0, _node_3656));
                float4 _lightDir_var = UNITY_ACCESS_INSTANCED_PROP( Props, _lightDir );
                float4 _node_4500_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_4500 );
                float _lightden_var = UNITY_ACCESS_INSTANCED_PROP( Props, _lightden );
                float3 _node_4552_var = lerp( _node_3656_var.rgb, ((((dot(normalize(_lightDir_var.rgb),i.normalDir)*0.5+0.5)*_node_4500_var.rgb)*_lightden_var)*_node_3656_var.rgb), UNITY_ACCESS_INSTANCED_PROP( Props, _node_4552 ) );
                float3 emissive = _node_4552_var;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
