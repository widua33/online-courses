require 'swagger_helper'

RSpec.describe 'api/v1/competencies', type: :request do
  shared_examples 'settings' do
    tags 'Компетенции'
    consumes 'application/json'
    produces 'application/json'
  end

  competency_parameter_schema = {
    type: :object,
    required: %i[name course_id],
    properties: {
      name: { type: :string },
      course_id: { type: :integer }
    }
  }

  let(:course_id) { FactoryBot.create(:course).id }

  path '/api/v1/competencies' do
    get('Список компетенций') do
      include_examples 'settings'

      response(200, 'Список компетенций получен') do
        schema(
          type: :object,
          properties: {
            competencies: {
              type: :array,
              items: { '$ref' => '#/components/schemas/competency' }
            }
          }
        )

        run_test!
      end
    end

    post('Создать компетенцию') do
      include_examples 'settings'

      parameter name: :competency, in: :body, schema: competency_parameter_schema, required: false

      response(201, 'Компетенция создана') do
        schema('$ref' => '#/components/schemas/competency')

        let(:competency) { { name: 'Engineering', course_id: course_id } }

        run_test!
      end

      response(400, 'Cервер не может обработать запрос') do
        schema('$ref' => '#/components/schemas/bad_request_error')

        run_test!
      end

      response(422, 'При обработке данных произошла ошибка') do
        schema('$ref' => '#/components/schemas/unprocessable_entity_error')

        let(:competency) { { name: '', course_id: nil } }

        run_test!
      end
    end
  end

  path '/api/v1/competencies/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('Получить компетенцию') do
      include_examples 'settings'

      response(200, 'Компетенция получена') do
        schema('$ref' => '#/components/schemas/competency')

        let(:id) { FactoryBot.create(:competency).id }

        run_test!
      end

      response(404, 'Компетенция не найдена') do
        let(:id) { 123 }

        run_test!
      end
    end

    put('Обновить компетенцию') do
      include_examples 'settings'

      parameter name: :competency, in: :body, schema: competency_parameter_schema, required: false

      let(:id) { FactoryBot.create(:competency).id }

      response(200, 'Компетенция обновлена') do
        schema('$ref' => '#/components/schemas/competency')

        let(:competency) { { name: 'Engineering', course_id: course_id } }

        run_test!
      end

      response(400, 'Cервер не может обработать запрос') do
        schema('$ref' => '#/components/schemas/bad_request_error')

        let(:competency) {}

        run_test!
      end

      response(404, 'Компетенция не найдена') do
        let(:id) { 123 }

        run_test!
      end

      response(422, 'При обработке данных произошла ошибка') do
        schema('$ref' => '#/components/schemas/unprocessable_entity_error')

        let(:competency) { { name: '', course_id: nil } }

        run_test!
      end
    end

    delete('Удалить компетенцию') do
      include_examples 'settings'

      parameter name: 'id', in: :path, type: :string, description: 'id'

      response(204, 'Компетенция удалена') do
        let(:id) { FactoryBot.create(:competency).id }

        run_test!
      end

      response(404, 'Компетенция не найдена') do
        let(:id) { 123 }

        run_test!
      end
    end
  end
end
