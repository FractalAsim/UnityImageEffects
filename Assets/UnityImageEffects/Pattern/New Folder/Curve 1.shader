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

            float2 _Mouse;
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

                float mx = mod(gl_FragCoord.x, 10.0);
				if(mx < 5.0) 
				{
					color = 0.0;
				} 
                else 
				{
					color = 1.0;	
				}

                return vec4( vec3( color, color, color), 1.0 );;
            }

            ENDCG
        }
    }
}
