{
	programs.lazygit = {
		enable = true;
		settings = {
			git = {
				paging = {
					colorArg = "always";
					pager = "delta --dark --paging=never";
				};
			};
			customCommands = [
				{
					key = "<c-v>";
					context = "global";
					description = "Create new conventional commit";
					prompts = [
						{
							type = "menu";
							key = "Type";
							title = "Type of change";
							options = [
								{
									name = "build";
									description = "Changes that affect the build system or external dependencies";
									value = "build";
								}
								{
									name = "feat";
									description = "A new feature";
									value = "feat";
								}
								{
									name = "fix";
									description = "A bug fix";
									value = "fix";
								}
								{
									name = "chore";
									description = "Other changes that don't modify src or test files";
									value = "chore";
								}
								{
									name = "ci";
									description = "Changes to CI configuration files and scripts";
									value = "ci";
								}
								{
									name = "docs";
									description = "Documentation only changes";
									value = "docs";
								}
								{
									name = "perf";
									description = "A code change that improves performance";
									value = "perf";
								}
								{
									name = "refactor";
									description = "A code change that neither fixes a bug nor adds a feature";
									value = "refactor";
								}
								{
									name = "revert";
									description = "Reverts a previous commit";
									value = "revert";
								}
								{
									name = "style";
									description = "Changes that do not affect the meaning of the code";
									value = "style";
								}
								{
									name = "test";
									description = "Adding missing tests or correcting existing tests";
									value = "test";
								}
							];
						}
						{
							type = "menu";
							key = "Breaking";
							title = "Breaking change";
							options = [
								{
									name = "no";
									value = "";
								}
								{
									name = "yes";
									value = "!";
								}
							];
						}
						{
							type = "input";
							title = "message";
							key = "Message";
							initialValue = "";
						}
						{
							type = "confirm";
							key = "Confirm";
							title = "Commit";
							body = "Are you sure you want to commit?";
						}
					];
					command = "git commit --message '{{.Form.Type}}{{ if .Form.Scope }}({{ .Form.Scope }}){{ end }}{{.Form.Breaking}}: {{.Form.Message}}'";
					loadingText = "Creating conventional commit...";
				}
				{
					key = "<c-a>";
					description = "Pick AI commit";
					context = "files";
					output = "terminal";
					command = ''
					   aichat --model ollama:llama3.2 "Generate 4 conventional commit messages for the staged changes.
					
					   **Staged Changes:**
					   \`\`\`diff
					   $(git diff --cached --name-status)
					   $(git diff --cached)
					   \`\`\`
					
					   **Requirements:**
					   - Format: \`type: description\`
					   - Types: feat, fix, refactor, perf, docs, test, chore, style, ci
					   - Prioritize user impact
					   - Be specific and concise
					   - Mix high-level and detailed messages
					
					   **Output format - commit messages only, one per line:**" \
					     | fzf --height 40% --border --ansi --preview "echo {}" --preview-window=up:wrap \
					     | xargs -I {} bash -c '
					         COMMIT_MSG_FILE=$(mktemp)
					         echo "{}" > "$COMMIT_MSG_FILE"
					         ${"\${EDITOR:-vim}"} "$COMMIT_MSG_FILE"
					         if [ -s "$COMMIT_MSG_FILE" ]; then
					             git commit -F "$COMMIT_MSG_FILE"
					         else
					             echo "Commit message is empty, commit aborted."
					         fi
					         rm -f "$COMMIT_MSG_FILE"'				'';
				}
			];
		};
	};
}
