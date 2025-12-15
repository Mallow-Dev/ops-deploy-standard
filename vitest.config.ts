import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true,
    environment: 'node',
    coverage: {
      provider: 'c8',
      reporter: ['text', 'lcov'],
      statements: 100,
      branches: 100,
      functions: 100,
      lines: 100,
    },
  },
});
