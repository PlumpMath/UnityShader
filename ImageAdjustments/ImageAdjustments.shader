Shader "Hidden/MonoLightTech/ImageAdjustments"
{
	Properties
	{
		_MainTex("Base (RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM

			#pragma vertex vert_img
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;

			uniform float _brightness;
			uniform float _saturation;
			uniform float _contrast;

			uniform float _intensity;
			uniform float _multiplier;

			float3 f3(float v) { return float3(v, v, v); }

			fixed4 frag(v2f_img img) : SV_Target
			{
				float4 texCol = tex2D(_MainTex, img.uv);

				// Sharpen
				float4 sTexCol = texCol * 9.0f;
				float2 off = 1.0f / (_ScreenParams / _multiplier);

				sTexCol -= tex2D(_MainTex, img.uv + float2(0.0f, off.y));
				sTexCol -= tex2D(_MainTex, img.uv + float2(0.0f, -off.y));
				sTexCol -= tex2D(_MainTex, img.uv + float2(off.x, 0.0f));
				sTexCol -= tex2D(_MainTex, img.uv + float2(-off.x, 0.0f));
				sTexCol -= tex2D(_MainTex, img.uv + float2(-off.x, off.y));
				sTexCol -= tex2D(_MainTex, img.uv + float2(off.x, off.y));
				sTexCol -= tex2D(_MainTex, img.uv + float2(-off.x, -off.y));
				sTexCol -= tex2D(_MainTex, img.uv + float2(off.x, -off.y));

				texCol = lerp(texCol, sTexCol, _intensity);

				// Brightness
				texCol.rgb *= _brightness;

				// Saturation
				float3 lumCoeff = float3(0.2126, 0.7152, 0.0722);
				texCol.rgb = lerp(f3(dot(texCol, lumCoeff)), texCol, _saturation);

				// Contrast
				texCol.rgb = lerp(f3(.5), texCol, _contrast);

				return texCol;
			}

			ENDCG
		}
	}
}
