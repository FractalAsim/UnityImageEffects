using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class HalftoneBlit : MonoBehaviour
{
    [SerializeField] Material mat;

    [SerializeField, Range(0, 2)] float PointSize = 1;
    [SerializeField, Range(0, 50)] float Size = 30;
    [SerializeField, Range(0, 360)] float AngleRed = 75;
    [SerializeField, Range(0, 360)] float AngleGreen = 45;
    [SerializeField, Range(0, 360)] float AngleBlue = 15;

    [SerializeField] bool monochrome = false;
    [SerializeField] bool invert = false;

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (mat == null) return;

        mat.SetFloat("_pointSize", PointSize);
        mat.SetFloat("_frequency", Size);

        mat.SetVector("_sines", new Vector3(
            Mathf.Sin(AngleRed * Mathf.Deg2Rad),
            Mathf.Sin(AngleGreen * Mathf.Deg2Rad),
            Mathf.Sin(AngleBlue * Mathf.Deg2Rad)
        ));
        mat.SetVector("_cosines", new Vector3(
            Mathf.Cos(AngleRed * Mathf.Deg2Rad),
            Mathf.Cos(AngleGreen * Mathf.Deg2Rad),
            Mathf.Cos(AngleBlue * Mathf.Deg2Rad)
        ));

        mat.SetFloat("_mono", (monochrome) ? 1.0f : 0.0f);
        mat.SetFloat("_invert", (invert) ? 1.0f : 0.0f);

        Graphics.Blit(source, destination, mat);
    }
}
