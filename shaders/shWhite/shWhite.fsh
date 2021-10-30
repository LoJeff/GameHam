//
// Simple passthrough fragment shader
// how we draw every pixel
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord ); //copy color and draw
	gl_FragColor = vec4(1.0,1.0,1.0, gl_FragColor.a); //rgb and alpha
}
