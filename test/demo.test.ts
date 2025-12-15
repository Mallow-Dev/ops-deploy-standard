import { describe, it, expect } from 'vitest';
import request from 'supertest';
import { app } from '../demo/src/index';

describe('demo app', () => {
  it('root returns ok and env', async () => {
    const res = await request(app).get('/');
    expect(res.status).toBe(200);
    expect(res.body.ok).toBe(true);
    expect(res.body.env.NODE_ENV).toBeDefined();
  });
});
