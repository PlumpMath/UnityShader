Shader "Hidden/MonoLightTech/Sharpen"
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
			uniform float _intensity;
			uniform float _multiplier;

			fixed4 frag(v2f_img image) : SV_Target
			{
				float4 textureColor = tex2D(_MainTex, image.uv);
				float4 sharpenedTextureColor = textureColor * 9.0f;
				float2 offset = 1.0f / (_ScreenParams / _multiplier);

				sharpenedTextureColor -= tex2D(_MainTex, image.uv + float2(0.0f, offset.y));
				sharpenedTextureColor -= tex2D(_MainTex, image.uv + float2(0.0f, -offset.y));
				sharpenedTextureColor -= tex2D(_MainTex, image.uv + float2(offset.x, 0.0f));
				sharpenedTextureColor -= tex2D(_MainTex, image.uv + float2(-offset.x, 0.0f));
				sharpenedTextureColor -= tex2D(_MainTex, image.uv + float2(-offset.x, offset.y));
				sharpenedTextureColor -= tex2D(_MainTex, image.uv + float2(offset.x, offset.y));
				sharpenedTextureColor -= tex2D(_MainTex, image.uv + float2(-offset.x, -offset.y));
				sharpenedTextureColor -= tex2D(_MainTex, image.uv + float2(offset.x, -offset.y));

				return lerp(textureColor, sharpenedTextureColor, _intensity);
			}

			ENDCG
		}
	}
}
