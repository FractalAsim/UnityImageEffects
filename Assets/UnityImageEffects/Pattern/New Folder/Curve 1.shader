Shader "Pattern/Curve"
{
    Properties
    {
        _UVScale("UVScale",Range(1, 10)) = 1
        _Offset("Offset",Vector) = (0,0,0,0)
        _Radius("Radius",Range(1, 10)) = 5
        _Rotation("Rotation",Range(0, 4)) = 1
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

            float _UVScale;
            float2 _Offset;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.pos);

                o.uv = v.uv;

                return o;
            }

            float hex(float2 p) 
			{
				p.x *= 0.57735 * 2.0;
				p.y += fmod(floor(p.x), 2.0) * 0.5;
				p = abs((fmod(p, 1.0) - 0.5));
				return abs(max(p.x * 1.5 + p.y, p.y * 2.0) - 1.0);
			}

            float pattern(float2 p)
			{
				p.x *= 0.866; // = sqrt(3)/2
				p.x -= p.y * 0.5;

				p = fmod(p,1.0);

				return p.x + p.y < 1.0 ? 0.0 : 1.0;
			}

            fixed4 frag (v2f i) : SV_Target
            {
                // Scale
                //i.uv *= _UVScale;

                // Move
                i.uv -= _Offset.xy;

				float2 pos = i.uv.xy * 500;

				float p = pos/20.0; 

                float r = (1.0 - 0.7) * 0.5;

                float4 color = pattern(pos * .0173);
                float4 color2;

                color2.rg = frac(i.uv);

                return color;
            }

            ENDCG   
        }
    }
}
