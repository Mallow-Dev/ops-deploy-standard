import { vi, describe, it, expect, afterEach } from 'vitest';
import fetchMock from 'fetch-mock';

import { loginWithAppRole, readSecretKV, loadSecretsToEnv } from '../node/vault-client';

describe('vault-client', () => {
  afterEach(() => fetchMock.restore());

  it('loginWithAppRole returns token on success', async () => {
    fetchMock.post('http://127.0.0.1:8200/v1/auth/approle/login', {
      status: 200,
      body: { auth: { client_token: 'tok-123' } },
    });
    const t = await loginWithAppRole('r', 's');
    expect(t).toBe('tok-123');
  });

  it('readSecretKV returns data', async () => {
    fetchMock.get('http://127.0.0.1:8200/v1/secret/data/my/path', {
      status: 200,
      body: { data: { data: { KEY: 'VALUE' } } },
    });
    const d = await readSecretKV('my/path', 'tok-123');
    expect(d).toEqual({ KEY: 'VALUE' });
  });

  it('loadSecretsToEnv sets env vars if not present', async () => {
    fetchMock.post('http://127.0.0.1:8200/v1/auth/approle/login', {
      status: 200,
      body: { auth: { client_token: 'tok-123' } },
    });
    fetchMock.get('http://127.0.0.1:8200/v1/secret/data/demo', {
      status: 200,
      body: { data: { data: { A: '1', B: '2' } } },
    });
    delete process.env.A; delete process.env.B;
    await loadSecretsToEnv('r', 's', 'demo');
    expect(process.env.A).toBe('1');
    expect(process.env.B).toBe('2');
  });
});
