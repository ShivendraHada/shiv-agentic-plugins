# Test Templates

This document provides templates for creating tests using the agentic TDD workflow. These templates follow Wiser Solutions' coding standards and best practices.

## Unit Test Templates

### Service Test Template

```typescript
import { Test, TestingModule } from '@nestjs/testing';
import { YourService } from './your.service';
import { Logger } from '@nestjs/common';
import { MockProvider } from '@libs/testing';

describe('YourService', () => {
    let service: YourService;
    let mockDependency: jest.Mocked<DependencyService>;

    beforeEach(async () => {
        const module: TestingModule = await Test.createTestingModule({
            providers: [
                YourService,
                MockProvider(DependencyService),
                {
                    provide: Logger,
                    useValue: {
                        log: jest.fn(),
                        error: jest.fn(),
                        warn: jest.fn(),
                        debug: jest.fn(),
                        verbose: jest.fn(),
                    },
                },
            ],
        }).compile();

        service = module.get<YourService>(YourService);
        mockDependency = module.get(DependencyService);
    });

    it('should be defined', () => {
        expect(service).toBeDefined();
    });

    describe('methodName', () => {
        it('should [expected behavior] when [condition]', async () => {
            // Arrange
            const input = {
                // Test input data
            };
            mockDependency.someMethod.mockResolvedValue({
                // Mock return value
            });

            // Act
            const result = await service.methodName(input);

            // Assert
            expect(result).toEqual({
                // Expected output
            });
            expect(mockDependency.someMethod).toHaveBeenCalledWith(
                // Expected parameters
            );
        });

        it('should throw an error when [error condition]', async () => {
            // Arrange
            const input = {
                // Test input data
            };
            mockDependency.someMethod.mockRejectedValue(new Error('Test error'));

            // Act & Assert
            await expect(service.methodName(input)).rejects.toThrow('Test error');
        });
    });
});
```

### Controller Test Template

```typescript
import { Test, TestingModule } from '@nestjs/testing';
import { YourController } from './your.controller';
import { YourService } from './your.service';
import { MockProvider } from '@libs/testing';

describe('YourController', () => {
    let controller: YourController;
    let mockService: jest.Mocked<YourService>;

    beforeEach(async () => {
        const module: TestingModule = await Test.createTestingModule({
            controllers: [YourController],
            providers: [MockProvider(YourService)],
        }).compile();

        controller = module.get<YourController>(YourController);
        mockService = module.get(YourService);
    });

    it('should be defined', () => {
        expect(controller).toBeDefined();
    });

    describe('endpointName', () => {
        it('should [expected behavior] when [condition]', async () => {
            // Arrange
            const dto = {
                // Test input data
            };
            mockService.serviceMethod.mockResolvedValue({
                // Mock return value
            });

            // Act
            const result = await controller.endpointName(dto);

            // Assert
            expect(result).toEqual({
                // Expected output
            });
            expect(mockService.serviceMethod).toHaveBeenCalledWith(
                // Expected parameters
            );
        });
    });
});
```

### Repository Test Template

```typescript
import { Test, TestingModule } from '@nestjs/testing';
import { YourRepository } from './your.repository';
import { getRepositoryToken } from '@nestjs/typeorm';
import { YourEntity } from './your.entity';
import { Logger } from '@nestjs/common';

describe('YourRepository', () => {
    let repository: YourRepository;
    let mockEntityRepository: any;

    beforeEach(async () => {
        mockEntityRepository = {
            find: jest.fn(),
            findOne: jest.fn(),
            save: jest.fn(),
            update: jest.fn(),
            delete: jest.fn(),
            createQueryBuilder: jest.fn(() => ({
                where: jest.fn().mockReturnThis(),
                andWhere: jest.fn().mockReturnThis(),
                leftJoinAndSelect: jest.fn().mockReturnThis(),
                orderBy: jest.fn().mockReturnThis(),
                getOne: jest.fn(),
                getMany: jest.fn(),
            })),
        };

        const module: TestingModule = await Test.createTestingModule({
            providers: [
                YourRepository,
                {
                    provide: getRepositoryToken(YourEntity),
                    useValue: mockEntityRepository,
                },
                {
                    provide: Logger,
                    useValue: {
                        log: jest.fn(),
                        error: jest.fn(),
                        warn: jest.fn(),
                        debug: jest.fn(),
                        verbose: jest.fn(),
                    },
                },
            ],
        }).compile();

        repository = module.get<YourRepository>(YourRepository);
    });

    it('should be defined', () => {
        expect(repository).toBeDefined();
    });

    describe('findByCondition', () => {
        it('should [expected behavior] when [condition]', async () => {
            // Arrange
            const condition = {
                // Test condition
            };
            const expectedResult = [
                // Expected entities
            ];
            mockEntityRepository.find.mockResolvedValue(expectedResult);

            // Act
            const result = await repository.findByCondition(condition);

            // Assert
            expect(result).toEqual(expectedResult);
            expect(mockEntityRepository.find).toHaveBeenCalledWith({
                where: condition,
            });
        });
    });
});
```

## Integration Test Templates

### Database Integration Test

```typescript
import { Test, TestingModule } from '@nestjs/testing';
import { TypeOrmModule } from '@nestjs/typeorm';
import { YourRepository } from './your.repository';
import { YourEntity } from './your.entity';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { DatabaseModule } from '../database/database.module';

describe('YourRepository Integration', () => {
    let repository: YourRepository;
    let module: TestingModule;

    beforeAll(async () => {
        module = await Test.createTestingModule({
            imports: [
                ConfigModule.forRoot({
                    isGlobal: true,
                    envFilePath: '.env.test',
                }),
                DatabaseModule,
                TypeOrmModule.forFeature([YourEntity]),
            ],
            providers: [YourRepository],
        }).compile();

        repository = module.get<YourRepository>(YourRepository);
    });

    afterAll(async () => {
        await module.close();
    });

    beforeEach(async () => {
        // Clean up the test database before each test
        const entityManager = module.get('CONNECTION').createEntityManager();
        await entityManager.query('TRUNCATE TABLE your_table CASCADE');
    });

    it('should [expected behavior] when [condition]', async () => {
        // Arrange
        const testEntity = {
            // Test entity data
        };

        // Act
        const savedEntity = await repository.save(testEntity);
        const foundEntity = await repository.findOne(savedEntity.id);

        // Assert
        expect(foundEntity).toBeDefined();
        expect(foundEntity.property).toEqual(testEntity.property);
    });
});
```

### API Integration Test

```typescript
import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from '../src/app.module';
import { setupApp } from '../src/setup-app';

describe('YourController (e2e)', () => {
    let app: INestApplication;

    beforeAll(async () => {
        const moduleFixture: TestingModule = await Test.createTestingModule({
            imports: [AppModule],
        }).compile();

        app = moduleFixture.createNestApplication();
        setupApp(app); // Apply global middleware, pipes, etc.
        await app.init();
    });

    afterAll(async () => {
        await app.close();
    });

    describe('/endpoint (METHOD)', () => {
        it('should [expected behavior] when [condition]', async () => {
            // Arrange
            const payload = {
                // Test payload
            };

            // Act & Assert
            return request(app.getHttpServer())
                .post('/endpoint')
                .send(payload)
                .expect(201)
                .expect((response) => {
                    expect(response.body).toEqual(
                        expect.objectContaining({
                            // Expected response properties
                        }),
                    );
                });
        });

        it('should return 400 when validation fails', async () => {
            // Arrange
            const invalidPayload = {
                // Invalid test payload
            };

            // Act & Assert
            return request(app.getHttpServer())
                .post('/endpoint')
                .send(invalidPayload)
                .expect(400)
                .expect((response) => {
                    expect(response.body.message).toContain('validation failed');
                });
        });
    });
});
```

### GraphQL Integration Test

```typescript
import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from '../src/app.module';
import { setupApp } from '../src/setup-app';

describe('GraphQL API (e2e)', () => {
    let app: INestApplication;

    beforeAll(async () => {
        const moduleFixture: TestingModule = await Test.createTestingModule({
            imports: [AppModule],
        }).compile();

        app = moduleFixture.createNestApplication();
        setupApp(app);
        await app.init();
    });

    afterAll(async () => {
        await app.close();
    });

    describe('yourQuery', () => {
        it('should [expected behavior] when [condition]', async () => {
            // Arrange
            const query = `
                query {
                    yourQuery(input: {
                        # Query variables
                    }) {
                        # Requested fields
                        id
                        name
                    }
                }
            `;

            // Act & Assert
            return request(app.getHttpServer())
                .post('/graphql')
                .send({ query })
                .expect(200)
                .expect((response) => {
                    expect(response.body.data.yourQuery).toEqual(
                        expect.objectContaining({
                            // Expected response properties
                        }),
                    );
                });
        });
    });

    describe('yourMutation', () => {
        it('should [expected behavior] when [condition]', async () => {
            // Arrange
            const mutation = `
                mutation {
                    yourMutation(input: {
                        # Mutation variables
                    }) {
                        # Requested fields
                        id
                        name
                    }
                }
            `;

            // Act & Assert
            return request(app.getHttpServer())
                .post('/graphql')
                .send({ query: mutation })
                .expect(200)
                .expect((response) => {
                    expect(response.body.data.yourMutation).toEqual(
                        expect.objectContaining({
                            // Expected response properties
                        }),
                    );
                });
        });
    });
});
```

## Temporal.IO Test Templates

### Workflow Test Template

```typescript
import { TestWorkflowEnvironment } from '@temporalio/testing';
import { Worker } from '@temporalio/worker';
import { yourWorkflow } from '../src/workflows';
import * as activities from '../src/activities';

describe('YourWorkflow', () => {
    let testEnv: TestWorkflowEnvironment;
    let worker: Worker;

    beforeAll(async () => {
        testEnv = await TestWorkflowEnvironment.create();
    });

    afterAll(async () => {
        await testEnv?.teardown();
    });

    beforeEach(async () => {
        worker = await Worker.create({
            connection: testEnv.nativeConnection,
            taskQueue: 'test-queue',
            workflowsPath: require.resolve('../src/workflows'),
            activities: {
                ...Object.fromEntries(
                    Object.entries(activities).map(([key, val]) => [
                        key,
                        jest.fn(val),
                    ]),
                ),
            },
        });

        await worker.run();
    });

    afterEach(async () => {
        await worker?.shutdown();
    });

    it('should [expected behavior] when [condition]', async () => {
        // Arrange
        const input = {
            // Test input
        };

        // Mock activities if needed
        const mockActivities = worker.activities as jest.Mocked<typeof activities>;
        mockActivities.yourActivity.mockImplementation(async () => {
            return {
                // Mock activity result
            };
        });

        // Act
        const result = await testEnv.client.workflow.execute(yourWorkflow, {
            args: [input],
            taskQueue: 'test-queue',
            workflowId: 'test-workflow-id',
        });

        // Assert
        expect(result).toEqual({
            // Expected workflow result
        });
        expect(mockActivities.yourActivity).toHaveBeenCalledWith(
            // Expected activity parameters
        );
    });
});
```

### Activity Test Template

```typescript
import { Context } from '@temporalio/activity';
import { yourActivity } from '../src/activities';

// Mock the activity context
jest.mock('@temporalio/activity', () => ({
    Context: {
        current: {
            info: {
                workflowExecution: {
                    workflowId: 'test-workflow-id',
                },
                activityId: 'test-activity-id',
            },
        },
    },
}));

describe('YourActivity', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    it('should [expected behavior] when [condition]', async () => {
        // Arrange
        const input = {
            // Test input
        };

        // Mock dependencies if needed
        jest.spyOn(SomeDependency.prototype, 'method').mockResolvedValue({
            // Mock return value
        });

        // Act
        const result = await yourActivity(input);

        // Assert
        expect(result).toEqual({
            // Expected activity result
        });
        expect(SomeDependency.prototype.method).toHaveBeenCalledWith(
            // Expected parameters
        );
    });
});
```

## Best Practices for Tests

1. **Follow the AAA Pattern**:
   - **Arrange**: Set up the test data and conditions
   - **Act**: Perform the action being tested
   - **Assert**: Verify the results

2. **Test Naming**:
   - Use descriptive names following the pattern: 'should [expected behavior] when [condition]'
   - Group related tests using `describe` blocks

3. **Mock External Dependencies**:
   - Use the `MockProvider` utility for NestJS dependencies
   - Create specific mock implementations for expected behavior
   - Verify that mocks are called with the correct parameters

4. **Test Edge Cases**:
   - Test both successful and error scenarios
   - Include tests for boundary conditions
   - Test with empty, null, and invalid inputs

5. **Maintain Test Independence**:
   - Each test should be able to run independently
   - Clean up test data before/after tests
   - Avoid test interdependencies

6. **Coverage Requirements**:
   - Maintain minimum 95% test coverage
   - Focus on testing business logic thoroughly
   - Don't just test for coverage, test for correctness

7. **Performance Considerations**:
   - Keep tests fast to enable quick feedback
   - Use appropriate setup/teardown hooks
   - Consider using in-memory databases for integration tests

For more examples and best practices, refer to the [testing documentation](../docs/testing.md).
