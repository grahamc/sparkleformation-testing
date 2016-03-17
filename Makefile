TEMPLATE=cloudformation.json
STACKNAME=ShoutcastSFN


test:
	nix-shell --run "sfn validate  --no-processing --file ${TEMPLATE}"

create: parameters.oneline
	nix-shell --run "sfn create \
                            --no-interactive-parameters \
                            --no-processing \
                            --file ${TEMPLATE} \
                            -m '$$(cat parameters.oneline)' \
                            '${STACKNAME}'"

dry-run: parameters.oneline
	nix-shell --run "sfn update \
                            --no-interactive-parameters \
                            --no-processing \
                            --file ${TEMPLATE} \
                            -m '$$(cat parameters.oneline)' \
                            '${STACKNAME}'"

update: parameters.oneline
	# add --yes to actually update
	nix-shell --run "sfn update \
                            --no-interactive-parameters \
                            --no-processing \
                            --file ${TEMPLATE} \
                            -m '$$(cat parameters.oneline)' \
                            '${STACKNAME}'"


parameters.oneline: parameters
	cat parameters | awk 'BEGIN { ORS="," } { print $$0; }' > parameters.oneline
