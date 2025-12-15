import fetch from 'node-fetch';

export async function loginWithAppRole(roleId: string, secretId: string, vaultAddr = 'http://127.0.0.1:8200') {
  const res = await fetch(`${vaultAddr}/v1/auth/approle/login`, {
    method: 'POST',
    body: JSON.stringify({ role_id: roleId, secret_id: secretId }),
    headers: { 'Content-Type': 'application/json' },
  });
  if (!res.ok) throw new Error(`AppRole login failed: ${res.status} ${await res.text()}`);
  const json = await res.json();
  return json.auth.client_token as string;
}

export async function readSecretKV(path: string, token: string, vaultAddr = 'http://127.0.0.1:8200') {
  const res = await fetch(`${vaultAddr}/v1/secret/data/${path}`, {
    method: 'GET',
    headers: { 'X-Vault-Token': token },
  });
  if (!res.ok) throw new Error(`read secret failed: ${res.status} ${await res.text()}`);
  const json = await res.json();
  return json.data?.data || {};
}

export async function loadSecretsToEnv(roleId: string, secretId: string, path: string, vaultAddr?: string) {
  const token = await loginWithAppRole(roleId, secretId, vaultAddr);
  const secrets = await readSecretKV(path, token, vaultAddr);
  for (const k of Object.keys(secrets)) {
    if (!process.env[k]) process.env[k] = String(secrets[k]);
  }
}
