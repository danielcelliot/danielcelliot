# Intuit E-Commerce

Intuit is a work-in-progress multi-vendor marketplace (e-commerce), built using modern open-source technologies and [Jamstack](https://jamstack.org/) design principles.

Technologies used:

### Frontend

- [SvelteKit](https://kit.svelte.dev/) (NodeJS) web application framework
- [Typescript](https://www.typescriptlang.org/) programming language
- [TailwindCSS](https://tailwindcss.com/) CSS framework
- [ShadCN](https://www.shadcn-svelte.com/) component library
- [Melt UI](https://melt-ui.com/) component library
- [SuperForms](https://superforms.rocks/) form validation library

### Backend

- [MedusaJS](https://medusajs.com/) Headless E-Commerce backend service
- [Meilisearch](https://www.meilisearch.com/) Search Engine backend service
- Amazon [AWS RDS Postgresql](https://aws.amazon.com/rds/) relational database
- [Redis](https://redis.io/) In-memory database (used for API request caching)
- [Minio](https://min.io/) Object Store (for product image uploads)
- [imgproxy](https://imgproxy.net/) Image processing/optimization
