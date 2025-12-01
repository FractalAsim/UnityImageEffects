Shader "Grid/NewUnlitShader"
{
    Properties
    {
        _Scale("Scale",Range(1, 40)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM

            #pragma vertex vert // Use "vert" function for Vertex Shader
            #pragma fragment frag // Use "frag" function for Fragment Shader

            //#include "UnityCG.cginc"

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

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.pos);

                o.uv = v.uv;

                return o;
            }

            float _Scale;

            float map(float s0, float s1, float d0, float d1, float x) {
				return lerp(d0, d1, (x-s0)/(s1-s0));
			}

            fixed4 frag (v2f i) : SV_Target
            {
                float2 pos = i.uv.xy * _Scale;

                float b = step(1, fmod(pos.x, 2));

                b = step(fmod(pos.x, 1),0.5);

                //b = step(frac(pos.x), 0.5);

                //b *= step(1, fmod(pos.y, 2));

				float3 c = b;

                float4 color = float4(c,1);
                
                return color;
            }

            ENDCG
        }
    }
}
