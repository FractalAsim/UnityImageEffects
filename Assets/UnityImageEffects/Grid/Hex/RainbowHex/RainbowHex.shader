Shader "Hex/RainbowHex"
{
    Properties
    {
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM

            #pragma vertex vert // Use "vert" function for Vertex Shader
            #pragma fragment frag // Use "frag" function for Fragment Shader

            #include "Assets/UnityImageEffects/cginc/Hash.cginc"

            // Input to Vertex Shader
            struct appdata
            {
                float4 pos : POSITION;
                float2 uv : TEXCOORD0;
            };

            // Input to Fragment Shader
            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            float4 _Color;
            float2 _Mouse;

            float3 hash31(float2 uv)
			{
				return float3(
                    hash21(uv),
                    hash21(uv+float2(213,2151)),
                    hash21(uv+float2(123124,2323)));
			}

            float2 hexify(float2 p,float hexCount)
			{
				p *= hexCount;
				float3 p2 = floor(float3(p.x/0.86602540378,p.y+0.57735026919*p.x,p.y-0.57735026919*p.x));
				float y = floor((p2.y+p2.z)/3.0);
				float x = floor((p2.x+(1.0-fmod(y,2.0)))/2.0);
				return float2(x,y)/hexCount;
			}
            float2 cMul(float2 a,float2 b)
			{
				return float2(
                    a.x*b.x-a.y*b.y,
                    a.x*b.y+a.y*b.x);
			}

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.pos);

                o.uv = v.uv;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 p = i.uv/_ScreenParams.xy * 1000;
				p.x *= _ScreenParams.x/_ScreenParams.y;
				p = hexify(p,20.0);

                float4 color = float4(hash31(p),1);
                
                return color;
            }

            ENDCG
        }
    }
}
