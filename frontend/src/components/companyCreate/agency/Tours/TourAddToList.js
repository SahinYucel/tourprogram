import React, { useState, useEffect, useCallback } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';
import { saveTourData } from '../../../../services/api';

const TourAddToList = () => {
  // Tour states
  const [tourName, setTourName] = useState('');
  const [tours, setTours] = useState(() => {
    const savedTours = localStorage.getItem('tourList');
    return savedTours ? JSON.parse(savedTours) : [];
  });
  const [counter, setCounter] = useState(() => {
    const savedCounter = localStorage.getItem('tourCounter');
    return savedCounter ? parseInt(savedCounter) : 1;
  });

  // Region states
  const [regionName, setRegionName] = useState('');
  const [regions, setRegions] = useState(() => {
    const savedRegions = localStorage.getItem('regionList');
    const parsedRegions = savedRegions ? JSON.parse(savedRegions) : [];
    return parsedRegions.map(region => ({
      ...region,
      areas: region.areas || []
    }));
  });
  const [regionCounter, setRegionCounter] = useState(() => {
    const savedCounter = localStorage.getItem('regionCounter');
    return savedCounter ? parseInt(savedCounter) : 1;
  });

  // Area states
  const [areaName, setAreaName] = useState('');
  const [selectedRegionId, setSelectedRegionId] = useState(null);

  const [isCollapsed, setIsCollapsed] = useState(false);
  const [isRegionCollapsed, setIsRegionCollapsed] = useState(false);
  const [isAreaCollapsed, setIsAreaCollapsed] = useState(false);
  const [isSaving, setIsSaving] = useState(false);

  // Save to localStorage
  useEffect(() => {
    localStorage.setItem('tourList', JSON.stringify(tours));
    localStorage.setItem('tourCounter', counter.toString());
    localStorage.setItem('regionList', JSON.stringify(regions));
    localStorage.setItem('regionCounter', regionCounter.toString());
  }, [tours, counter, regions, regionCounter]);

  // Tour handlers
  const handleTourSubmit = useCallback((e) => {
    e.preventDefault();
    if (!tourName.trim()) return;

    const newTour = {
      id: counter,
      name: tourName.trim()
    };

    setTours(prev => [...prev, newTour]);
    setCounter(prev => prev + 1);
    setTourName('');
  }, [tourName, counter]);

  // Region handlers
  const handleRegionSubmit = useCallback((e) => {
    e.preventDefault();
    if (!regionName.trim()) return;

    const newRegion = {
      id: regionCounter,
      name: regionName.trim(),
      areas: []
    };

    setRegions(prev => [...prev, newRegion]);
    setRegionCounter(prev => prev + 1);
    setRegionName('');
  }, [regionName, regionCounter]);

  // Area handlers
  const handleAreaSubmit = useCallback((e) => {
    e.preventDefault();
    if (!areaName.trim() || !selectedRegionId) return;

    const newArea = {
      id: Date.now(),
      name: areaName.trim()
    };

    setRegions(prev => prev.map(region => 
      region.id === selectedRegionId
        ? { ...region, areas: [...region.areas, newArea] }
        : region
    ));
    setAreaName('');
  }, [areaName, selectedRegionId]);

  const handleDelete = useCallback((id, type, regionId) => {
    if (window.confirm(`Bu ${type}yi silmek istediğinizden emin misiniz?`)) {
      switch(type) {
        case 'tur':
          setTours(prev => prev.filter(item => item.id !== id));
          break;
        case 'bölge':
          setRegions(prev => prev.filter(item => item.id !== id));
          break;
        case 'alan':
          setRegions(prev => prev.map(region => 
            region.id === regionId
              ? { ...region, areas: region.areas.filter(area => area.id !== id) }
              : region
          ));
          break;
      }
    }
  }, []);

  const handleSaveToDatabase = async () => {
    try {
      setIsSaving(true);
      // Get company ID from the logged-in agency user
      const agencyUser = JSON.parse(localStorage.getItem('agencyUser'));
      
      if (!agencyUser?.companyId) {
        alert('Şirket bilgisi bulunamadı. Lütfen tekrar giriş yapın.');
        return;
      }

      const data = {
        tours,
        regions
      };

      await saveTourData(agencyUser.companyId, data);
      alert('Veriler başarıyla kaydedildi!');
    } catch (error) {
      console.error('Kaydetme hatası:', error);
      alert('Veriler kaydedilirken bir hata oluştu: ' + error.message);
    } finally {
      setIsSaving(false);
    }
  };

  const RegionRow = useCallback(({ region }) => (
    <>
      <tr className="table-light">
        <th scope="row">{region.id}</th>
        <td>{region.name}</td>
        <td>
          <button 
            className="btn btn-sm btn-danger"
            onClick={() => handleDelete(region.id, 'bölge')}
          >
            <i className="bi bi-trash"></i>
          </button>
        </td>
      </tr>
      {(region.areas || []).map(area => (
        <tr key={area.id} className="table-light" style={{ backgroundColor: 'rgba(0,0,0,0.02)' }}>
          <th scope="row" style={{ paddingLeft: '2rem' }}>└ {area.id}</th>
          <td style={{ paddingLeft: '2rem' }}>{area.name}</td>
          <td>
            <button 
              className="btn btn-sm btn-danger"
              onClick={() => handleDelete(area.id, 'alan', region.id)}
            >
              <i className="bi bi-trash"></i>
            </button>
          </td>
        </tr>
      ))}
    </>
  ), [handleDelete]);

  return (
    <div className="container mt-4">
      {/* Tour List */}
      <div className="card mb-4">
        <div 
          className="card-header" 
          style={{ cursor: 'pointer' }} 
          onClick={() => setIsCollapsed(prev => !prev)}
        >
          <div className="d-flex justify-content-between align-items-center">
            <h4 className="mb-0">Tur Adı Listesi</h4>
            <i className={`bi ${isCollapsed ? 'bi-chevron-down' : 'bi-chevron-up'}`}></i>
          </div>
        </div>
        <div className={`card-body ${isCollapsed ? 'd-none' : ''}`}>
          <form onSubmit={handleTourSubmit} className="mb-4">
            <div className="input-group">
              <input
                type="text"
                className="form-control"
                placeholder="Tur adı giriniz"
                value={tourName}
                onChange={(e) => setTourName(e.target.value)}
              />
              <button type="submit" className="btn btn-primary">
                <i className="bi bi-plus-lg me-2"></i>Ekle
              </button>
            </div>
          </form>

          {tours.length > 0 && (
            <div className="table-responsive">
              <table className="table table-hover">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Tur Adı</th>
                    <th scope="col">İşlemler</th>
                  </tr>
                </thead>
                <tbody>
                  {tours.map(tour => (
                    <tr key={tour.id}>
                      <th scope="row">{tour.id}</th>
                      <td>{tour.name}</td>
                      <td>
                        <button 
                          className="btn btn-sm btn-danger"
                          onClick={() => handleDelete(tour.id, 'tur')}
                        >
                          <i className="bi bi-trash"></i>
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>

      {/* Region and Area List */}
      <div className="card mb-4">
        <div 
          className="card-header" 
          style={{ cursor: 'pointer' }} 
          onClick={() => setIsRegionCollapsed(prev => !prev)}
        >
          <div className="d-flex justify-content-between align-items-center">
            <h4 className="mb-0">Bölgeler ve Alanlar</h4>
            <i className={`bi ${isRegionCollapsed ? 'bi-chevron-down' : 'bi-chevron-up'}`}></i>
          </div>
        </div>
        <div className={`card-body ${isRegionCollapsed ? 'd-none' : ''}`}>
          {/* Region Form */}
          <form onSubmit={handleRegionSubmit} className="mb-4">
            <div className="input-group">
              <input
                type="text"
                className="form-control"
                placeholder="Bölge adı giriniz"
                value={regionName}
                onChange={(e) => setRegionName(e.target.value)}
              />
              <button type="submit" className="btn btn-primary">
                <i className="bi bi-plus-lg me-2"></i>Bölge Ekle
              </button>
            </div>
          </form>

          {/* Area Form */}
          <form onSubmit={handleAreaSubmit} className="mb-4">
            <div className="input-group">
              <select
                className="form-select"
                value={selectedRegionId || ''}
                onChange={(e) => setSelectedRegionId(Number(e.target.value))}
                style={{ maxWidth: '200px' }}
              >
                <option value="">Bölge seçiniz</option>
                {regions.map(region => (
                  <option key={region.id} value={region.id}>
                    {region.name}
                  </option>
                ))}
              </select>
              <input
                type="text"
                className="form-control"
                placeholder="Alan adı giriniz"
                value={areaName}
                onChange={(e) => setAreaName(e.target.value)}
                disabled={!selectedRegionId}
              />
              <button 
                type="submit" 
                className="btn btn-primary"
                disabled={!selectedRegionId}
              >
                <i className="bi bi-plus-lg me-2"></i>Alan Ekle
              </button>
            </div>
          </form>

          {/* Region and Area Table */}
          {regions.length > 0 && (
            <div className="table-responsive">
              <table className="table">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">İsim</th>
                    <th scope="col">İşlemler</th>
                  </tr>
                </thead>
                <tbody>
                  {regions.map(region => (
                    <RegionRow key={region.id} region={region} />
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>

      {/* Save to Database Button */}
      <div className="d-grid gap-2 mb-4">
        <button 
          className="btn btn-success btn-lg"
          onClick={handleSaveToDatabase}
          disabled={isSaving || (tours.length === 0 && regions.length === 0)}
        >
          {isSaving ? (
            <>
              <span className="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
              Kaydediliyor...
            </>
          ) : (
            <>
              <i className="bi bi-cloud-upload me-2"></i>
              Veri Tabanına Kaydet
            </>
          )}
        </button>
      </div>
    </div>
  );
};

export default TourAddToList; 