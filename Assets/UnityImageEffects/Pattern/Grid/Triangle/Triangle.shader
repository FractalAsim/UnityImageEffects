Shader "Pattern/Triangle"
{
    Properties
    {
        _Spacing("Spacing",Range(1, 10)) = 1
        _Scale("Scale",Range(1, 100)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM

            #pragma vertex vert // Use "vert" function for Vertex Shader
            #pragma fragment frag // Use "frag" function for Fragment Shader
            
            #include "UnityCG.cginc" 

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

            float _Scale;
            float _Spacing;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.pos);

                o.uv = v.uv;

                return o;
            }

            float pattern(float2 p, float spacing)
			{
				p.x *= 0.866; // = sqrt(3)/2
				p.x -= p.y * 0.5; // Shear

				p = fmod(p,spacing);

				return p.x + p.y < 1.0 ? 0.0 : 1.0;
			}

            fixed4 frag (v2f i) : SV_Target
            {
                // Move
                i.uv.x += 1;

				float2 pos = i.uv.xy * _Scale;
                float4 color = pattern(pos, _Spacing);

                return color;
            }

            ENDCG   
        }
    }
}
