using System;
using UnityEngine;

namespace MonoLightTech.UnityShader
{
    [ExecuteInEditMode]
    [Serializable]
    public sealed class Sharpen : MonoBehaviour
    {
        [Range(-2, 2)]
        public float intensity = 1.0f;

        [Range(0, 8)]
        public float multiplier = 1.0f;

        private Material _material;

        private void Awake()
        {
            _material = new Material(Shader.Find("Hidden/MonoLightTech/Sharpen"));
        }

        private void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            _material.SetFloat("_intensity", intensity);
            _material.SetFloat("_multiplier", multiplier);

            Graphics.Blit(source, destination, _material);
        }
    }
}