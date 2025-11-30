Shader "Billboard/BasicBillboard"
{
    Properties
    {
        [NoScaleOffset] _MainTex("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags{"RenderType" = "Transparent" "Queue" = "Transparent"}

        ZWrite Off

        Blend SrcAlpha OneMinusSrcAlpha

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

            sampler2D _MainTex;
            float _ScaleX;
            float _ScaleY;

            float3 ExtractScale(float4x4 m)
            {
                float3 scale;
                scale.x = length(m._m00_m10_m20);
                scale.y = length(m._m01_m11_m21);
                scale.z = length(m._m02_m12_m22);
                return scale;
            }

            v2f vert(appdata v)
            {
                v2f o;

                // Bring Object Space to View Space
                float4 viewOrigin = float4(mul(UNITY_MATRIX_MV, float4(0,0,0,1)).xyz,1);

                // Apply Scale (transform.scale)
                float3 scale = ExtractScale(unity_ObjectToWorld);
                v.pos *= float4(scale.x, scale.y, 1.0, 1.0);

                // Calculate Pos in view space
                float4 posInViewSpace = viewOrigin + v.pos;
                
                // Project
                o.pos = mul(UNITY_MATRIX_P, posInViewSpace);

                o.uv = v.uv;

                return o;
            }

            fixed4 frag(v2f i) : SV_Target  
            {
                float4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}