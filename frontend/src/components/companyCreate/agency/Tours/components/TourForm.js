import React from 'react';
import FormInput from './FormInput';
import PickupTimeForm from './PickupTimeForm';
import PriceInputs from './PriceInputs';
import OptionInput from './OptionInput';
import DaySelector from './DaySelector';

const TourForm = ({
  tourData,
  formInputs,
  savedRegions,
  savedAreas,
  onSubmit,
  onChange,
  onTimeChange,
  onAddTime,
  onRemoveTime,
  onOptionChange,
  onAddOption,
  onRemoveOption,
  onDaySelect,
  onSelectAllDays
}) => {
  return (
    <form onSubmit={onSubmit}>
      {formInputs.map(input => (
        <FormInput
          key={input.id}
          {...input}
          value={tourData[input.id]}
          onChange={onChange}
        />
      ))}

      <PickupTimeForm
        pickupTimes={tourData.pickupTimes}
        savedRegions={savedRegions}
        savedAreas={savedAreas}
        onTimeChange={onTimeChange}
        onAddTime={onAddTime}
        onRemoveTime={onRemoveTime}
      />

      <PriceInputs
        adultPrice={tourData.adultPrice}
        childPrice={tourData.childPrice}
        onChange={onChange}
      />

      <OptionInput
        label="Opsiyonlar"
        icon="bi-plus-circle"
        options={tourData.options}
        onChange={onOptionChange}
        onAdd={onAddOption}
        onRemove={onRemoveOption}
      />

      <DaySelector
        selectedDays={tourData.selectedDays}
        onDaySelect={onDaySelect}
        onSelectAll={onSelectAllDays}
      />

      <div className="d-grid mt-4">
        <button 
          type="submit" 
          className={`btn ${tourData.editingIndex !== null ? 'btn-success' : 'btn-primary'}`}
          style={{ width: 'auto', margin: '0 auto' }}
        >
          <i className={`bi ${tourData.editingIndex !== null ? 'bi-check-lg' : 'bi-plus-lg'} me-2`}></i>
          {tourData.editingIndex !== null ? 'Değişiklikleri Kaydet' : 'Tur Oluştur'}
        </button>
      </div>
    </form>
  );
};

export default TourForm; 