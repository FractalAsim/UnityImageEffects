/*
 * Script to inject mouse in the material in play mode
*/

using UnityEngine;
using UnityEngine.InputSystem;

public class InjectMouse : MonoBehaviour
{
    void Update()
    {
        Ray r = RectTransformUtility.ScreenPointToRay(Camera.main, Mouse.current.position.ReadValue());
        if (Physics.Raycast(r, out var hitinfo))
        {
            var hitpos = hitinfo.textureCoord;

            var renderer = GetComponent<Renderer>();

            if (renderer == null)
            {
                Shader.SetGlobalVector("_Mouse", new Vector4(hitpos.x, hitpos.y, 0, 0));
                return;
            }

            Shader.SetGlobalVector("_Mouse", new Vector4(hitpos.x, hitpos.y, 0, 0));
        }
        else
        {
            Shader.SetGlobalVector("_Mouse", new Vector4(0.5f, 0.5f, 0, 0));
        }
    }
}
