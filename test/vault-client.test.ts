import { vi, describe, it, expect, afterEach } from 'vitest';

import { loginWithAppRole, readSecretKV, loadSecretsToEnv } from '../node/vault-client';

describe('vault-client', () => {
  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('loginWithAppRole returns token on success', async () => {
    vi.stubGlobal('fetch', vi.fn(async () => ({ ok: true, json: async () => ({ auth: { client_token: 'tok-123' } }) })));
    const t = await loginWithAppRole('r', 's');
    expect(t).toBe('tok-123');
  });

  it('readSecretKV returns data', async () => {
    vi.stubGlobal('fetch', vi.fn(async () => ({ ok: true, json: async () => ({ data: { data: { KEY: 'VALUE' } } }) })));
    const d = await readSecretKV('my/path', 'tok-123');
    expect(d).toEqual({ KEY: 'VALUE' });
  });

  it('loadSecretsToEnv sets env vars if not present', async () => {
    const calls: any[] = [];
    vi.stubGlobal('fetch', vi.fn(async (url: string) => {
      calls.push(url);
      if (url.endsWith('/v1/auth/approle/login')) return { ok: true, json: async () => ({ auth: { client_token: 'tok-123' } }) } as any;
      return { ok: true, json: async () => ({ data: { data: { A: '1', B: '2' } } }) } as any;
    }));
    delete process.env.A; delete process.env.B;
    await loadSecretsToEnv('r', 's', 'demo');
    expect(process.env.A).toBe('1');
    expect(process.env.B).toBe('2');
    expect(calls.length).toBeGreaterThanOrEqual(2);
  });
});
