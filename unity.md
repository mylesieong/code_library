# Unity Learnings

## Understand size and scale in Unity
* GameObject doesn't have size, its just a transform scale
* What really has size is Mesh, in the inspector your can view it
* The actual GameObject size = Mesh.size * Transform.localScale
* The final box collider size = BoxCollider.size * Transform.localScale

## Debug
* Debug.Log($"Your debug text and debug {value}");
* Physical Debugger can show the Collider at runtime
* When model inside out: F3 search recalculate or flip (https://answers.unity.com/questions/1485224/when-i-import-a-blender-model-it-turns-out-inside.html)

## Other
* Monobehavior is a class from Unity scripting API, check API and version history here: https://docs.unity3d.com/2019.4/Documentation/ScriptReference/30_search.html?q=Singleton
* In a script, field will be shown in inspector not only for public field, but also for private field with [SerializeField] marks
* Only setActive is false, Game object will not be shown on screen and in Hierarachy it will be grey too
* Check play and developer can adjust the object's setActive live!
* In visual studio open project *.sln then its easy to find reference of methods, e.g. LevelAim.cs>AddPoint is refered from Player.cs>Cut
* Plugin is pro-only and is code. Package is downloadable and contains assets, sound, script and etc
* If missing texture after importing fbx into Unity, click object and export texture from the inspectator>Material Tab>Export Texture https://forum.unity.com/threads/missing-textures-from-imported-fbx-file-in-unity-since-update.518577/
