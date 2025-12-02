Shader "Grid/BasicGrid"
{
    Properties
    {
        _Scale("Scale",Range(1, 40)) = 1
        [Toggle] _Invert("Invert",float) = 0
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

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.pos);

                o.uv = v.uv;

                return o;
            }

            float2 _Mouse;
            float _Scale;
            float _Invert;

            fixed4 frag (v2f i) : SV_Target
            {
                i.uv -= _Mouse;

                float2 pos = i.uv.xy * _Scale;

                float b;

                // Vertical
                b = step(frac(pos.x), 0.5);

                // Horizontal
                b += step(frac(pos.y), 0.5);

                b = b - _Invert;

                float4 color = float4(b,b,b,1);
                return color;
            }

            ENDCG
        }
    }
}
