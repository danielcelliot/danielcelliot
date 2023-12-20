import { MINIO_PASSWORD, MINIO_USER } from '$env/static/private';
import * as Minio from 'minio';

export const minioClient = new Minio.Client({
	endPoint: 'localhost',
	port: 9090,
	accessKey: MINIO_USER,
	secretKey: MINIO_PASSWORD,
	useSSL: false
});
