#!/bin/bash

set -ex

GLOAM="${GLOAM:-gloam}"

APIS="gl:core,gles2,vulkan,egl,glx,wgl"
APIS_BASELINE="gl:core=3.3,gles2=3.0"

EXTENSIONS=(
	# Base, include everything
	all

	# Exclude obsolete extensions
	-GL_EXT_direct_state_access
	-GL_EXT_separate_shader_objects
	-GL_EXT_vertex_shader
	-GL_SUNX_constant_data
	-GL_SUN_convolution_border_modes
	-GL_SUN_global_alpha
	-GL_SUN_mesh_array
	-GL_SUN_slice_accum
	-GL_SUN_triangle_list
	-GL_SUN_vertex
	-GL_SGIX_async
	-GL_SGIX_async_histogram
	-GL_SGIX_async_pixel
	-GL_SGIX_blend_alpha_minmax
	-GL_SGIX_calligraphic_fragment
	-GL_SGIX_clipmap
	-GL_SGIX_convolution_accuracy
	-GL_SGIX_depth_pass_instrument
	-GL_SGIX_depth_texture
	-GL_SGIX_flush_raster
	-GL_SGIX_fog_offset
	-GL_SGIX_fragment_lighting
	-GL_SGIX_framezoom
	-GL_SGIX_igloo_interface
	-GL_SGIX_instruments
	-GL_SGIX_interlace
	-GL_SGIX_ir_instrument1
	-GL_SGIX_list_priority
	-GL_SGIX_pixel_texture
	-GL_SGIX_pixel_tiles
	-GL_SGIX_polynomial_ffd
	-GL_SGIX_reference_plane
	-GL_SGIX_resample
	-GL_SGIX_scalebias_hint
	-GL_SGIX_shadow
	-GL_SGIX_shadow_ambient
	-GL_SGIX_sprite
	-GL_SGIX_subsample
	-GL_SGIX_tag_sample_buffer
	-GL_SGIX_texture_add_env
	-GL_SGIX_texture_coordinate_clamp
	-GL_SGIX_texture_lod_bias
	-GL_SGIX_texture_multi_buffer
	-GL_SGIX_texture_scale_bias
	-GL_SGIX_vertex_preclip
	-GL_SGIX_ycrcb
	-GL_SGIX_ycrcb_subsample
	-GL_SGIX_ycrcba
	-GL_NV_half_float
	-GL_OES_byte_coordinates

	# Exclude extensions we don't care about, with long command strings that
	# waste space in the command name buffer
	-GL_ANGLE_robust_client_memory
	-GL_ANGLE_shader_pixel_local_storage

	# Explicitly add some extensions
	GL_ARB_texture_buffer_object
	GL_ARB_texture_compression
	GL_ARB_texture_multisample
	GL_ARB_provoking_vertex
	GL_ARB_query_buffer_object
	GL_ARB_uniform_buffer_object
	GL_EXT_multi_draw_arrays
	GL_EXT_provoking_vertex
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
	--extensions="${extlist}"

	# e.g. ARB_parallel_shader_compile -> KHR_parallel_shader_compile
	--predecessors

	# e.g. ARB_multitexture promoted to core
	--promoted

	# Can be more restrictive, e.g. "gl:core=3.3", but you have to account for
	# other differences such as some GLOAM_GL_VERSION_* macros not being defined
	--api="$APIS"

	# Automatically exclude extensions we can assume are present because
	# they're part of our baseline profiles
	--baseline="$APIS_BASELINE"

	--out-path "$THIS_DIR"
	--merge
	c
	--alias
	--loader
)

exec "${GLOAM}" "${GLOAM_ARGS[@]}"
