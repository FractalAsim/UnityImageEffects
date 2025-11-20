using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class PhotomaticEffectBlit : MonoBehaviour
{
    [SerializeField] Material mat;

    [SerializeField, Range(0, 1)] float _hue = 0.5f;
    [SerializeField, Range(0, 1)] float _saturation = 0.5f;
    [SerializeField, Range(0, 1)] float _brightness = 0.5f;
    [SerializeField, Range(0, 1)] float _contrast = 0.5f;

    [SerializeField] bool _invert;
    [SerializeField] bool _mirrorX;
    [SerializeField] bool _mirrorY;

    [SerializeField, Range(1, 4)] float _zoom = 1;

    [SerializeField] Color _colorMask = Color.white;

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (mat == null) return;

        float hue = Mathf.Repeat(_hue - 0.5f, 1);
        mat.SetVector("_hsbc", new Vector4(hue, _saturation, _brightness, _contrast));
        mat.SetVector("_fx", new Vector4(_mirrorX ? 1 : 0, _mirrorY ? 1 : 0, _invert ? 1 : 0, _zoom));
        mat.SetColor("_colorMask", _colorMask);

        Graphics.Blit(source, destination, mat);
    }
}
