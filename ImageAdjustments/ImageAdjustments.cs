using System;
using UnityEngine;

namespace MonoLightTech.UnityShader
{
    [ExecuteInEditMode]
    [Serializable]
    public sealed class ImageAdjustments : MonoBehaviour
    {
        [Range(0, 2)]
        public float brightness = 1.0f;

        [Range(0, 2)]
        public float saturation = 1.0f;

        [Range(0, 2)]
        public float contrast = 1.0f;

        [Header("Sharpen")]
        [Range(-2, 2)]
        public float intensity = 1.0f;

        [Range(0, 8)]
        public float multiplier = 1.0f;

        private Material _material;

        private void Awake()
        {
            _material = new Material(Shader.Find("Hidden/MonoLightTech/ImageAdjustments"));
        }

        private void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            _material.SetFloat("_brightness", brightness);
            _material.SetFloat("_saturation", saturation);
            _material.SetFloat("_contrast", contrast);

            _material.SetFloat("_intensity", intensity);
            _material.SetFloat("_multiplier", multiplier);

            Graphics.Blit(source, destination, _material);
        }
    }
}