# frozen_string_literal: true

require 'swagger_helper'

describe 'Items API' do
  path '/tems' do
    post 'Creates an item' do
      tags 'Items'
      consumes 'application/json', 'application/xml'
      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          done: { type: :boolean },
          todo_id: { type: :integer }
        },
        required: %w[name description done todo_id]
      }

      response '201', 'Item created' do
        let(:item) { { name: 'foo', description: 'bar', done: false, todo_id: 1 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:item) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/items/{id}' do
    get 'Retrieves an item' do
      tags 'Items'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'blog found' do
        schema type: :object,
               properties: {
                 name: { type: :string },
                 description: { type: :string },
                 done: { type: :boolean },
                 todo_id: { type: :integer }
               },
               required: %w[name description done todo_id]

        let(:id) do
          Item.create(
            name: 'foo',
            description: 'bar',
            done: false,
            todo_id: 1
          ).id
        end
        run_test!
      end

      response '404', 'item not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/foo' }
        run_test!
      end
    end
  end
end
