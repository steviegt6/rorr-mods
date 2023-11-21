using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Tomat.Umbrella.Host.Platform;

namespace Tomat.Umbrella.Host;

internal static unsafe class Program {
    [UnmanagedCallersOnly(EntryPoint = "DllMain", CallConvs = new[] { typeof(CallConvStdcall) })]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static bool DllMain(void* hModule, uint reasonForCall, void* reserved) {
        if (reasonForCall != 1 /* DLL_PROCESS_ATTACH */)
            return true;

        var platform = IPlatform.MakePlatform();

        if (!platform.InitializeConsole()) {
            platform.ShowMessageBox("Umbrella API Host: Fatal Error", "Failed to initialize console.");
            return false;
        }

        Console.WriteLine("TEST!!!");

        return true;
    }

#region Common proxy targets
#region dbgcore.dll
    [UnmanagedCallersOnly(EntryPoint = "MiniDumpReadDumpStream", CallConvs = new[] { typeof(CallConvStdcall) })]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static bool MiniDumpReadDumpStream(void* p1, ulong p2, void* p3, void* p4, void* p5) {
        return false;
    }

    [UnmanagedCallersOnly(EntryPoint = "MiniDumpWriteDump", CallConvs = new[] { typeof(CallConvStdcall) })]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static bool MiniDumpWriteDump(void* p1, uint p2, void* p3, uint p4, void* p5, void* p6, void* p7) {
        return false;
    }
#endregion
#endregion
}
