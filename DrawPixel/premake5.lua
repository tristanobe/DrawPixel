-- DrawPixel/premake5.lua
project "DrawPixel"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"

    BuildsInfos("%{prj.name}")

    files { "./src/**.cpp", "./src/**.h" }
    includedirs { "./src" }

    -- Windows (ClangCL)
    filter "system:windows"
        links { "msvcrt" }  -- Lien avec la bibliothèque standard Windows
        buildoptions { "/Wall" } -- Avertissements maximum pour ClangCL

        --links { "SDL3" }
        --includedirs { libs.sdl3.include}
        --libdirs { libs.sdl3.lib.msvc }

        -- Postbuild step to copy SDL3.dll to the output directory
        --PostBuilds2(libs.sdl3.lib.msvc, "SDL3", "%{prj.name}")

    -- Linux
    filter "system:linux"
        links { "pthread", "dl" }  -- Ajout des dépendances système standard
        buildoptions { "-Wall", "-Wextra", "-Wpedantic", "-Wshadow", "-Werror" }
        linkoptions { "-static-libstdc++" }

        -- Liens avec SDL3 pour Linux
        --links { "SDL3" }
        --includedirs { libs.sdl3.include }
        --libdirs { libs.sdl3.lib.mingw }

        -- Commande post-build spécifique pour Linux (si nécessaire)
        --PostBuilds2(libs.sdl3.lib.mingw, "SDL3", "%{prj.name}")

    -- macOS
    filter "system:macosx"
        buildoptions { "-Wall", "-Wextra", "-Wpedantic", "-Wshadow", "-Werror" }
        linkoptions { "-stdlib=libc++" }