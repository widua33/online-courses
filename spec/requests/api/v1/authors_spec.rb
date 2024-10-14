require 'swagger_helper'

RSpec.describe 'api/v1/authors', type: :request do
  shared_examples 'settings' do
    tags 'Авторы'
    consumes 'application/json'
    produces 'application/json'
  end

  author_parameter_schema = {
    type: :object,
    required: %i[first_name last_name],
    properties: {
      first_name: { type: :string },
      last_name: { type: :string }
    }
  }

  path '/api/v1/authors' do
    get('Список авторов') do
      include_examples 'settings'

      response(200, 'Список авторов получен') do
        schema(
          type: :object,
          properties: {
            authors: {
              type: :array,
              items: { '$ref' => '#/components/schemas/author' }
            }
          }
        )

        run_test!
      end
    end

    post('Создать автора') do
      include_examples 'settings'

      parameter name: :author, in: :body, schema: author_parameter_schema, required: false

      response(201, 'Автор создан') do
        schema('$ref' => '#/components/schemas/author')

        let(:author) { { first_name: 'John', last_name: 'Doe' } }

        run_test!
      end

      response(400, 'Cервер не может обработать запрос') do
        schema('$ref' => '#/components/schemas/bad_request_error')

        run_test!
      end

      response(422, 'При обработке данных произошла ошибка') do
        schema('$ref' => '#/components/schemas/unprocessable_entity_error')

        let(:author) { { first_name: '', last_name: '' } }

        run_test!
      end
    end
  end

  path '/api/v1/authors/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('Получить автора') do
      include_examples 'settings'

      response(200, 'Автор получен') do
        schema('$ref' => '#/components/schemas/author')

        let(:id) { FactoryBot.create(:author).id }

        run_test!
      end

      response(404, 'Автор не найден') do
        let(:id) { 123 }

        run_test!
      end
    end

    put('Обновить автора') do
      include_examples 'settings'

      parameter name: :author, in: :body, schema: author_parameter_schema, required: false

      let(:id) { FactoryBot.create(:author).id }

      response(200, 'Автор обновлен') do
        schema('$ref' => '#/components/schemas/author')

        let(:author) { { first_name: 'John', last_name: 'Doe' } }

        run_test!
      end

      response(400, 'Cервер не может обработать запрос') do
        schema('$ref' => '#/components/schemas/bad_request_error')

        let(:author) {}

        run_test!
      end

      response(404, 'Автор не найден') do
        let(:id) { 123 }

        run_test!
      end

      response(422, 'При обработке данных произошла ошибка') do
        schema('$ref' => '#/components/schemas/unprocessable_entity_error')

        let(:author) { { first_name: '', last_name: '' } }

        run_test!
      end
    end

    delete('Удалить автора') do
      include_examples 'settings'

      parameter name: 'id', in: :path, type: :string, description: 'id'

      let(:id) { FactoryBot.create(:author).id }

      response(204, 'Автор удален') do
        before { FactoryBot.create(:author) }

        run_test!
      end

      response(404, 'Автор не найден') do
        let(:id) { 123 }

        run_test!
      end

      response(422, 'Не получилось удалить автора') do
        schema('$ref' => '#/components/schemas/unprocessable_entity_error')

        run_test!
      end
    end
  end
end
