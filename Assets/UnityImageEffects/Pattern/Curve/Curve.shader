Shader "Pattern/Curve"
{
    Properties
    {
        _Scale("Scale",Range(1, 10)) = 1
        _Freq("Freq",Range(1, 100)) = 1
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

            float _Scale;
            float _Freq;
            float _Radius;
            float _Rotation;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.pos);

                o.uv = v.uv;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				float2 pos = (i.uv.xy * 2 - float2(1,1)) * 80 * _Scale;

                float angle = atan2(pos.y, pos.x) + _Rotation;
                float4 color = smoothstep(2.0,3.0,
                    abs(length(pos) - 50.0 + sin(angle * _Freq - UNITY_PI / 2.0) * _Radius));
                
                return color;
            }

            ENDCG
        }
    }
}
