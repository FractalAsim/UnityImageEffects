/*
 * Script to inject mouse in the material in play mode
*/

using System;
using UnityEngine;
using UnityEngine.InputSystem;

public class InjectMouse : MonoBehaviour
{
    Material lastSharedMaterial;
    void Update()
    {
        Ray r = RectTransformUtility.ScreenPointToRay(Camera.main, Mouse.current.position.ReadValue());
        if (Physics.Raycast(r, out var hitinfo))
        {
            var hitpos = hitinfo.textureCoord;

            var renderer = GetComponent<Renderer>();
            if (renderer == null) return;
            lastSharedMaterial = renderer.sharedMaterial;
            if (lastSharedMaterial == null) return;

            lastSharedMaterial.SetVector("mouse", new Vector4(hitpos.x, hitpos.y, 0, 0));
        }
        else if (lastSharedMaterial != null)
        {
            lastSharedMaterial.SetVector("mouse", new Vector4(0.5f, 0.5f, 0, 0));
            lastSharedMaterial = null;
        }
    }
}
