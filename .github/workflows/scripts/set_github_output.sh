# Helper to set GitHub Actions job output variables

set_github_output() {
	# Inputs (environment variables):
	# - GITHUB_OUTPUT (from GitHub Actions)

	# Inputs (arguments):
	# - var_name: The name of the environment variable to set
	# - var_value: The value of the environment variable to set
	# - verbose: Whether to output verbose information (true/false) (default: true)

	local var_name="$1"
	local var_value="$2"
	local is_verbose="$(
		if [ -z "$3" ] || [ "$3" = 'true' ] || [ "$3" = '1' ] || [ "$3" = 'verbose' ];
		then echo 'true'; else echo 'false'; fi
	)"

	# Verify var_name is not empty
	if [ -z "${var_name}" ]; then
		echo 'Error: Variable name is empty' >&2
		return 1
	fi

	# Verbose output
	if [ "${is_verbose}" = 'true' ]; then
		echo "Set ${var_name} to '${var_value}'"
	fi

	# Export the GitHub Actions job output variable
	echo "${var_name}<<GITHUB_OUTPUT_EOF" >> "$GITHUB_OUTPUT"
	echo "${var_value}" >> "$GITHUB_OUTPUT"
	echo "GITHUB_OUTPUT_EOF" >> "$GITHUB_OUTPUT"
}
