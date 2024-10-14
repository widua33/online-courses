require 'rails_helper'

RSpec.describe Authors::Destroy do
  subject(:destroy) { described_class.new(author: author).call }

  let(:course) { FactoryBot.build(:course) }
  let!(:author) { FactoryBot.create(:author, courses: [course]) }

  it 'destroys author' do
    new_author = FactoryBot.create(:author)

    expect { destroy }
      .to change(Author, :count).by(-1)
      .and change{ course.reload.author_id }.from(author.id).to(new_author.id)
    expect(destroy).to be_success
  end

  context 'no other available authors' do
    it 'returns failure' do
      expect(destroy.failure).to eq(author: 'нет других доступных авторов')
    end
  end

  context 'cannot destroy author' do
    it 'returns failure' do
      FactoryBot.create(:author)

      expect(author).to receive(:destroy).and_raise(PG::ForeignKeyViolation)
      expect(destroy.failure).to eq(author: 'невозможно удалить запись')
    end
  end
end
