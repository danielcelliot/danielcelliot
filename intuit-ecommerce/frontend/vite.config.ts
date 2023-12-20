import { sveltekit } from '@sveltejs/kit/vite';
import { enhancedImages } from '@sveltejs/enhanced-img';
import { nodeLoaderPlugin } from '@vavite/node-loader/plugin';
import { defineConfig, type PluginOption } from 'vite';

// export default defineConfig({
// 	plugins: [sveltekit(), nodeLoaderPlugin()],
// 	server: {
// 		port: 3000
// 	}
// });

export default defineConfig(({ mode }) => {
	let plugins: PluginOption[] = [enhancedImages(), sveltekit()];
	const server = { port: 3000 };
	if (mode === 'development') {
		plugins = [nodeLoaderPlugin(), ...plugins];
	}

	return {
		plugins,
		server
	};
});
