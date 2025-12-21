shader_type spatial;

uniform vec4 q;

vec4 qmul(vec4 a, vec4 b) {
	return vec4(
		a.w*b.xyz + b.w*a.xyz + cross(a.xyz,b.xyz),
		a.w*b.w - dot(a.xyz,b.xyz)
	);
}

vec3 rotate(vec3 v, vec4 q) {
	vec4 qc = vec4(-q.xyz, q.w);
	return qmul(qmul(q, vec4(v, 0.0)), qc).xyz;
}

void vertex() {
	VERTEX = rotate(VERTEX, q);
}
