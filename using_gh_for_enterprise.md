# Using `gh` with GitHub Enterprise (self-hosted)

Quick reference for using the GitHub CLI (`gh`) against a self‑hosted GitHub Enterprise instance.

Key points
- Use the `--hostname` flag (or specify the hostname during auth) to target a non‑github.com host.
- `gh` supports both interactive OAuth login and non‑interactive PAT token login.
- Ensure the PAT has required scopes (`repo` / `public_repo`, org scopes if creating org repos).
- If your Enterprise server uses a private/self‑signed TLS certificate, make sure the certificate is trusted by the OS so `gh` can connect.

Examples

- Interactive login (recommended for humans):

```bash
gh auth login --hostname github.your-company.com
```

- Non-interactive login using a Personal Access Token (automations/CI):

```bash
# export GHE_TOKEN with your PAT (must include repo scopes)
echo "$GHE_TOKEN" | gh auth login --with-token --hostname github.your-company.com
```

- Create a new public repo on the enterprise host and push current directory:

```bash
gh repo create your-org/project1 \
  --hostname github.your-company.com \
  --public --source=. --remote=origin --push
```

- Set the default branch for a repo on the enterprise host:

```bash
gh repo edit your-org/project1 --hostname github.your-company.com --default-branch PRODUCTION
```

Notes & gotchas
- SAML/SSO: If your org enforces SSO, PATs may need SSO authorization before they can be used for org actions.
- TLS: For self‑signed certificates, add the CA to the system trust store so `gh`/curl/git won't fail.
- Automation: Store PATs in CI secret stores and use `echo "$TOKEN" | gh auth login --with-token --hostname ...` in CI steps.
- Permissions: Creating repos in an org requires the token owner to have the necessary org permissions.

Verification

```bash
gh --version
gh auth status --hostname github.your-company.com
```

If you want, I can add an example GitHub Actions workflow or CI snippet that logs in with a PAT and creates/pushes a repo.
