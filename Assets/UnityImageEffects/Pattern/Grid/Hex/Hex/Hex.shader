Shader "Hex"
{
    Properties
    {
        _Scale("Scale",Range(1, 10)) = 1
        _AnimateSpeed("_AnimateSpeed",Range(0, 10)) = 1

        _Thickness("Thicknesss",Range(0.05, 10)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM

            #pragma vertex vert // Use "vert" function for Vertex Shader
            #pragma fragment frag // Use "frag" function for Fragment Shader
            
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

            float _AnimateSpeed;
            float _Scale;
            float _BarNum;

            float _Thickness;
            float _b;

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

            fixed4 frag (v2f i) : SV_Target
            {
                i.uv.x += frac(_Time.x * _AnimateSpeed);

                float2 pos = i.uv.xy * _Scale;
                float col = step(_Thickness, hex(pos));

                return float4(col, col, col, 1);
            }

            ENDCG
        }
    }
}
