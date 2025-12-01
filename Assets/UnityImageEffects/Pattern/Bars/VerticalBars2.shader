// fmod Version

Shader "Pattern/VerticalBars2"
{
    Properties
    {
        _AnimateSpeed("_AnimateSpeed",Range(1, 10)) = 1
        _BarNum("BarNum",Range(1, 100)) = 1
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
            float _AnimateSpeed;
            float _BarNum;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.pos);

                o.uv = v.uv;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                _AnimateSpeed *= _Mouse.y;
                i.uv.y -= frac(_Time.x * _AnimateSpeed);

                i.uv.y -= - 1;
                float bars = step(fmod(i.uv.y * _BarNum,1), 0.5);

                return float4(bars, bars, bars, 1);
            }

            ENDCG
        }
    }
}
