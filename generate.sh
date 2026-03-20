#!/bin/bash

set -ex

EXTENSIONS=(
	EGL_ANDROID_blob_cache
	EGL_ANGLE_colorspace_attribute_passthrough
	EGL_ANGLE_create_context_extensions_enabled
	EGL_ANGLE_create_surface_swap_interval
	EGL_ANGLE_device_d3d
	EGL_ANGLE_device_vulkan
	EGL_ANGLE_direct_composition
	EGL_ANGLE_display_power_preference
	EGL_ANGLE_feature_control
	EGL_ANGLE_platform_angle
	EGL_ANGLE_platform_angle_d3d
	EGL_ANGLE_platform_angle_d3d11on12
	EGL_ANGLE_platform_angle_d3d_luid
	EGL_ANGLE_platform_angle_device_id
	EGL_ANGLE_platform_angle_metal
	EGL_ANGLE_platform_angle_opengl
	EGL_ANGLE_platform_angle_vulkan
	EGL_ANGLE_platform_angle_vulkan_device_uuid
	EGL_ANGLE_program_cache_control
	EGL_ANGLE_surface_orientation
	EGL_EXT_device_query
	EGL_EXT_gl_colorspace_scrgb_linear
	EGL_EXT_platform_wayland
	EGL_EXT_platform_x11
	EGL_KHR_debug
	EGL_KHR_gl_colorspace
	GL_3DFX_texture_compression_FXT1
	GL_AMD_gpu_shader_half_float
	GL_AMD_gpu_shader_int16
	GL_AMD_performance_monitor
	GL_AMD_query_buffer_object
	GL_ANGLE_base_vertex_base_instance
	GL_ANGLE_lossy_etc_decode
	GL_ANGLE_multi_draw
	GL_ANGLE_program_binary
	GL_ANGLE_provoking_vertex
	GL_ANGLE_shader_binary
	GL_ANGLE_texture_compression_dxt5
	GL_ANGLE_texture_multisample
	GL_ANGLE_texture_usage
	GL_APPLE_clip_distance
	GL_APPLE_texture_format_BGRA8888
	GL_ARB_arrays_of_arrays
	GL_ARB_base_instance
	GL_ARB_buffer_storage
	GL_ARB_clip_control
	GL_ARB_conservative_depth
	GL_ARB_debug_output
	GL_ARB_direct_state_access
	GL_ARB_draw_indirect
	GL_ARB_get_program_binary
	GL_ARB_gpu_shader5
	GL_ARB_invalidate_subdata
	GL_ARB_multi_bind
	GL_ARB_multi_draw_indirect
	GL_ARB_multisample
	GL_ARB_pixel_buffer_object
	GL_ARB_query_buffer_object
	GL_ARB_sample_shading
	GL_ARB_shading_language_420pack
	GL_ARB_shading_language_packing
	GL_ARB_texture_filter_anisotropic
	GL_ARB_texture_gather
	GL_ARB_texture_storage
	GL_ARB_vertex_attrib_binding
	GL_EXT_base_instance
	GL_EXT_buffer_storage
	GL_EXT_clear_texture
	GL_EXT_clip_control
	GL_EXT_clip_cull_distance
	GL_EXT_debug_marker
	GL_EXT_direct_state_access
	GL_EXT_fragment_shader_barycentric
	GL_EXT_fragment_shading_rate
	GL_EXT_gpu_shader5
	GL_EXT_multi_draw_indirect
	GL_EXT_multisample
	GL_EXT_multisampled_render_to_texture
	GL_EXT_multisampled_render_to_texture2
	GL_EXT_pvrtc_sRGB
	GL_EXT_sRGB_write_control
	GL_EXT_shader_16bit_storage
	GL_EXT_shader_explicit_arithmetic_types
	GL_EXT_texture
	GL_EXT_texture_compression_dxt1
	GL_EXT_texture_compression_latc
	GL_EXT_texture_compression_rgtc
	GL_EXT_texture_compression_s3tc
	GL_EXT_texture_compression_s3tc_srgb
	GL_EXT_texture_env_combine
	GL_EXT_texture_filter_anisotropic
	GL_EXT_texture_format_BGRA8888
	GL_EXT_texture_sRGB
	GL_EXT_texture_storage
	GL_HUAWEI_program_binary
	GL_HUAWEI_shader_binary
	GL_IMG_texture_compression_pvrtc
	GL_IMG_texture_compression_pvrtc2
	GL_KHR_debug
	GL_KHR_parallel_shader_compile
	GL_MESA_program_binary_formats
	GL_NV_depth_buffer_float
	GL_NV_fence
	GL_NV_fragment_shader_barycentric
	GL_NV_sRGB_formats
	GL_OES_compressed_ETC1_RGB8_texture
	GL_OES_compressed_paletted_texture
	GL_OES_shader_image_atomic
	GL_OES_texture_compression_astc
	GL_QCOM_shading_rate
	GL_S3_s3tc
	GL_VIV_shader_binary
	VK_EXT_memory_budget
	VK_KHR_driver_properties
	VK_KHR_get_physical_device_properties2
	VK_KHR_portability_enumeration
	VK_KHR_timeline_semaphore
)
printf -v extlist '%s,' "${EXTENSIONS[@]}"

THIS_DIR="$PWD"
case "$(uname -s)" in
	CYGWIN*)
		THIS_DIR="$(cygpath -w "$PWD")"
		;;
esac

GLOAM_ARGS=(
	# If you enable this, it will only include the extensions we've explicitly
	# listed above.
	#--extensions="${extlist}"

	# Can be more restrictive, e.g. "gl:core=3.3", but you have to account for
	# other differences such as some GLOAM_GL_VERSION_* macros not being defined
	--api=gl:core,gles2,vulkan,egl,glx,wgl

	--out-path "$THIS_DIR"
	--merge
	c
	--alias
	--loader
)

# Faster profile for testing changes with the C generator
#GLOAM_ARGS=(
#	--reproducible
#	--api=gl:core=3.3
#	--out-path="$PWD"
#	--merge
#	c
#	--alias
#	--loader
#	--mx --mx-global
#	--header-only
#)

exec gloam "${GLOAM_ARGS[@]}"
