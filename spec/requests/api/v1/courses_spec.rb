require 'swagger_helper'

RSpec.describe 'api/v1/courses', type: :request do
  shared_examples 'settings' do
    tags 'Курсы'
    consumes 'application/json'
    produces 'application/json'
  end

  course_parameter_schema = {
    type: :object,
    required: %i[name author_id],
    properties: {
      name: { type: :string },
      author_id: { type: :integer }
    }
  }

  let(:author_id) { FactoryBot.create(:author).id }

  path '/api/v1/courses' do
    get('Список курсов') do
      include_examples 'settings'

      response(200, 'Список курсов получен') do
        schema(
          type: :object,
          properties: {
            courses: {
              type: :array,
              items: { '$ref' => '#/components/schemas/course' }
            }
          }
        )

        run_test!
      end
    end

    post('Создать курс') do
      include_examples 'settings'

      parameter name: :course, in: :body, schema: course_parameter_schema, required: false

      response(201, 'Курс создан') do
        schema('$ref' => '#/components/schemas/course')

        let(:course) { { name: 'Ruby internals', author_id: author_id } }

        run_test!
      end

      response(400, 'Cервер не может обработать запрос') do
        schema('$ref' => '#/components/schemas/bad_request_error')

        run_test!
      end

      response(422, 'При обработке данных произошла ошибка') do
        schema('$ref' => '#/components/schemas/unprocessable_entity_error')

        let(:course) { { name: '', author_id: nil } }

        run_test!
      end
    end
  end

  path '/api/v1/courses/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('Получить курс') do
      include_examples 'settings'

      response(200, 'Курс получен') do
        schema('$ref' => '#/components/schemas/course')

        let(:id) { FactoryBot.create(:course).id }

        run_test!
      end

      response(404, 'Курс не найден') do
        let(:id) { 123 }

        run_test!
      end
    end

    put('Обновить курс') do
      include_examples 'settings'

      parameter name: :course, in: :body, schema: course_parameter_schema, required: false

      let(:id) { FactoryBot.create(:course).id }

      response(200, 'Курс обновлен') do
        schema('$ref' => '#/components/schemas/course')

        let(:course) { { name: 'Ruby internals', author_id: author_id } }

        run_test!
      end

      response(400, 'Cервер не может обработать запрос') do
        schema('$ref' => '#/components/schemas/bad_request_error')

        let(:course) {}

        run_test!
      end

      response(404, 'Курс не найден') do
        let(:id) { 123 }

        run_test!
      end

      response(422, 'При обработке данных произошла ошибка') do
        schema('$ref' => '#/components/schemas/unprocessable_entity_error')

        let(:course) { { name: '', author_id: nil } }

        run_test!
      end
    end

    delete('Удалить курс') do
      include_examples 'settings'

      parameter name: 'id', in: :path, type: :string, description: 'id'

      response(204, 'Курс удален') do
        let(:id) { FactoryBot.create(:course).id }

        run_test!
      end

      response(404, 'Курс не найден') do
        let(:id) { 123 }

        run_test!
      end
    end
  end
end
