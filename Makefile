defaut: clean_cache

init:
	@terragrunt run-all init --reconfigure

clean_cache: 
	@find . -type d -name "*.terragrunt-cache*" -exec rm -rf {} \;