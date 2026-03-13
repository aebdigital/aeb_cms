import { useTranslation } from '../i18n'

const CarCard = ({ car, onClick, getImageUrl, currency = 'EUR', lang: forceLang }) => {
  const { t, lang: profileLang } = useTranslation();
  const lang = forceLang || profileLang;
  const isAdminAdded = car.source === 'admin';

  // Check if car is reserved (reservation date is in the future or boolean set)
  const isReserved = car.reserved || (car.reservedUntil && new Date(car.reservedUntil) > new Date());
  const isSold = car.sold;

  // Format reservation date
  const formatReservationDate = (dateStr) => {
    const date = new Date(dateStr);
    return date.toLocaleDateString(lang === 'cs' ? 'cs-CZ' : 'sk-SK', { day: '2-digit', month: '2-digit', year: 'numeric' });
  };

  // Get image URL - use provided function or fallback to direct path
  const imageUrl = getImageUrl ? getImageUrl(car.image) : car.image || 'https://via.placeholder.com/400x300?text=No+Image';

  return (
    <div
      className="bg-white shadow-lg overflow-hidden cursor-pointer hover:shadow-xl transition-all rounded-xl relative"
      onClick={onClick}
    >
      <div className="relative h-48 overflow-hidden">
        <img
          src={imageUrl}
          alt={`${car.brand} ${car.model}`}
          className="w-full h-full object-cover transition-transform duration-300 hover:scale-110"
        />
        <div className="absolute top-0 right-0 bg-gradient-to-r from-purple-600 to-blue-600 text-white px-4 py-2 rounded-bl-xl text-lg font-bold">
          {car.price.toLocaleString()} {currency}
        </div>
        <div className="absolute top-2 left-2 flex flex-col gap-2">
          {isSold ? (
            <div className="bg-red-600 text-white px-3 py-1 rounded-full text-xs font-bold shadow-lg uppercase">
              {t('predane', lang)}
            </div>
          ) : isReserved ? (
            <div className="bg-orange-500 text-white px-3 py-1 rounded-full text-xs font-bold shadow-lg uppercase">
              {t('rezervovane', lang)}
            </div>
          ) : null}
        </div>
      </div>
      <div className="px-4 pt-4 pb-4">
        <h3 className="text-lg font-bold text-gray-800 mb-2">
          {car.brand} {car.model}
        </h3>
        {isReserved && !isSold && car.reservedUntil && (
          <div className="mb-2 bg-orange-100 border border-orange-300 text-orange-800 px-2 py-1 rounded text-xs font-semibold">
            {t('rezervovane', lang)} do {formatReservationDate(car.reservedUntil)}
          </div>
        )}
        <div className="grid grid-cols-2 gap-2 text-sm text-gray-600">
          <div className="flex items-center">
            <span className="text-gray-500 mr-1">Rok:</span>
            <span className="font-semibold text-gray-800">{car.year}</span>
          </div>
          <div className="flex items-center">
            <span className="text-gray-500 mr-1">Palivo:</span>
            <span className="font-semibold text-gray-800">{car.fuel}</span>
          </div>
          <div className="flex items-center">
            <span className="text-gray-500 mr-1">Km:</span>
            <span className="font-semibold text-gray-800">{car.mileage.toLocaleString()}</span>
          </div>
          <div className="flex items-center">
            <span className="text-gray-500 mr-1">Vykon:</span>
            <span className="font-semibold text-gray-800">{car.power || 'N/A'}</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CarCard;
