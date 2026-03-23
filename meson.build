project('gloam', 'c', version: '0.1.1')

compiler = meson.get_compiler('c')
link_deps = [dependency('xxhash')]

incdirs = ['include']

sources = [
	'src/egl.c',
	'src/gl.c',
    'src/glx.c',
    'src/wgl.c',
	'src/vk.c',
]

incdirs = include_directories(incdirs)

lib = static_library(
    'gloam',
    sources,
    include_directories: incdirs,
    dependencies: link_deps,
)

gloam_dep = declare_dependency(
    include_directories: incdirs,
    dependencies: link_deps,
    link_with: lib,
    version: meson.project_version()
)

meson.override_dependency('gloam', gloam_dep)

# vim: set ts=4 sts=4 sw=4 et:
