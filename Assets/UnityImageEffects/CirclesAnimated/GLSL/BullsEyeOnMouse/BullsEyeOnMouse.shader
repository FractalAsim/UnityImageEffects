Shader "GLSL/BullsEyeOnMouse" 
{
	Properties
	{
		mouse ("Mouse", Vector) = (0.5,0.5,0,0)
	}
	SubShader
	{	
		Pass
		{
			GLSLPROGRAM // Begin GLSL

			#ifdef GL_ES
			precision mediump float;
			#endif

			uniform vec2 mouse;
			uniform vec4 _Time;

			#ifdef VERTEX // Begin vertex program/shader

			out vec4 texcoord;

			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex; // Draws the Vertex at the correct position in world

				texcoord = gl_MultiTexCoord0; // Pass UV
			}

			#endif // Ends vertex program/shader

			#ifdef FRAGMENT // Begin fragment program/shader

			in vec4 texcoord;

			void main()
			{
				float color = sin(distance(texcoord.xy, mouse.xy ) * 100 - _Time.y);

				gl_FragColor = vec4(color, color, color, 1.0);
			}

			#endif // Ends fragment program/shader

			ENDGLSL // End GLSL
		}
	}
}