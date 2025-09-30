{
	programs.lazygit = {
		enable = true;
		settings = {
			git = {
				paging = {
					colorArg = "always";
					pager = "delta --light --paging=never";
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
        aichat --model ollama:llama3.2 "Please suggest 10 commit messages, given the following diff:

        \`\`\`diff
        $(git diff --cached)
        \`\`\`

        **Criteria:**

        1. **Format:** Each commit message must follow the conventional commits format,
        which is \`<type>: <description>\`.
        2. **Relevance:** Avoid mentioning a module name unless it's directly relevant
        to the change.
        3. **Enumeration:** List the commit messages from 1 to 10.
        4. **Clarity and Conciseness:** Each message should clearly and concisely convey
        the change made.

        **Commit Message Examples:**

        - fix: add password regex pattern
        - feat: add new test cases
        - refactor: extract common code to \`utils/wait.ts\`

        **Recent Commits on Repo for Reference:**

        \`\`\`
        $(git log -n 10 --pretty=format:'%h %s')
        \`\`\`

        **Output Template**

        Follow this output template and ONLY output raw commit messages without spacing,
        numbers or other decorations.

        fix: add password regex pattern
        feat: added password check
        test: add new test cases
        refactor: extract common code to \`utils/wait.ts\`

        **Instructions:**

        - Take a moment to understand the changes made in the diff.

        - Think about the impact of these changes on the project (e.g., bug fixes, new
        features, performance improvements, code refactoring, documentation updates).
        It's critical to my career you abstract the changes to a higher level and not
        just describe the code changes.

        - Generate commit messages that accurately describe these changes, ensuring they
        are helpful to someone reading the project's history.

        - Remember, a well-crafted commit message can significantly aid in the maintenance
        and understanding of the project over time.

        - If multiple changes are present, make sure you capture them all in each commit
        message.

        Keep in mind you will suggest 10 commit messages. Only 1 will be used. It's
        better to push yourself (esp to synthesize to a higher level) and maybe wrong
        about some of the 10 commits because only one needs to be good. I'm looking
        for your best commit, not the best average commit. It's better to cover more
        scenarios than include a lot of overlap.

        Write your 10 commit messages below in the format shown in Output Template section above." \
          | fzf --height 40% --border --ansi --preview "echo {}" --preview-window=up:wrap \
          | xargs -I {} bash -c '
              COMMIT_MSG_FILE=$(mktemp)
              echo "{}" > "$COMMIT_MSG_FILE"
              ${"EDITOR:-vim"} "$COMMIT_MSG_FILE"
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
