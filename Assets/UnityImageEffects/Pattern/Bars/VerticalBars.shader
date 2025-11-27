Shader "Pattern/VerticalBars"
{
    Properties
    {
        _BarNum("BarNum",Range(1, 100)) = 1
        _Offset("Offset",float) = 1
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

            float2 _Mouse;
            float _BarNum;
            float _Offset;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.pos);

                o.uv = v.uv;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                i.uv.x += _Offset;
                float bars = step(frac(i.uv.y * _BarNum), 0.5);

                return float4(bars, bars, bars, 1);
            }

            ENDCG
        }
    }
}
