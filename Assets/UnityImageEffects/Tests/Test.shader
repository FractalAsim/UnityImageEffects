Shader "Tests/UVTest"
{
    Properties
    {
        _Offset("Offset",Vector) = (0,0,0,0)
        _Scale("Scale",Range(1, 1000)) = 1
        [Toggle] _Center("Center",float) = 0
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
            float2 _Offset;
            float _Scale;
            float _Center;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.pos);

                o.uv = v.uv;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Apply Center
                i.uv -= float2(0.5,0.5) * _Center;

                // Apply Scale
                i.uv *= _Scale;

                // Apply Offset
                i.uv -= _Offset;

                // Apply Mouse Move
                i.uv -= _Mouse - float2(0.5,0.5) * _Center;

                float color = length(i.uv) * 2;

                return color;
            }

            ENDCG
        }
    }
}
