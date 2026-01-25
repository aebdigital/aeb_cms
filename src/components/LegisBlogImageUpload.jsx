import React, { useState } from 'react';
import { PhotoIcon, CloudArrowUpIcon, XMarkIcon } from '@heroicons/react/24/outline';
import { uploadBlogImage, getPublicUrl } from '../api/storage';
import { compressImage } from '../lib/fileUtils';

const LegisBlogImageUpload = ({ siteSlug, blogId, onUploadSuccess, currentImageUrl }) => {
    const [uploading, setUploading] = useState(false);
    const [dragActive, setDragActive] = useState(false);

    const handleFileUpload = async (file) => {
        if (!file) return;

        setUploading(true);
        try {
            // 1. Compress image
            const compressedFile = await compressImage(file, 800, 1920, 1080);

            // 2. Upload to Supabase
            const { path } = await uploadBlogImage({
                file: compressedFile,
                siteSlug,
                blogId
            });

            // 3. Get public URL
            const url = getPublicUrl(path);

            // 4. Update form
            onUploadSuccess(url);
            alert('Obrázok bol úspešne nahraný!');
        } catch (err) {
            console.error('Upload error:', err);
            alert('Chyba pri nahrávaní obrázka: ' + (err.message || 'Neznáma chyba'));
        } finally {
            setUploading(false);
        }
    };

    const handleDrag = (e) => {
        e.preventDefault();
        e.stopPropagation();
        if (e.type === "dragenter" || e.type === "dragover") {
            setDragActive(true);
        } else if (e.type === "dragleave") {
            setDragActive(false);
        }
    };

    const handleDrop = (e) => {
        e.preventDefault();
        e.stopPropagation();
        setDragActive(false);
        if (e.dataTransfer.files && e.dataTransfer.files[0]) {
            handleFileUpload(e.dataTransfer.files[0]);
        }
    };

    const handleChange = (e) => {
        if (e.target.files && e.target.files[0]) {
            handleFileUpload(e.target.files[0]);
        }
    };

    return (
        <div className="space-y-2">
            <label className="block text-sm font-medium text-gray-700">Hlavný obrázok článku</label>

            <div
                className={`relative border-2 border-dashed rounded-xl transition-all ${dragActive ? 'border-indigo-600 bg-indigo-50' : 'border-gray-200 hover:border-gray-300'
                    }`}
                onDragEnter={handleDrag}
                onDragLeave={handleDrag}
                onDragOver={handleDrag}
                onDrop={handleDrop}
            >
                {currentImageUrl ? (
                    <div className="p-4">
                        <div className="relative group rounded-lg overflow-hidden h-48 border border-gray-100 bg-gray-50">
                            <img
                                src={currentImageUrl}
                                alt="Preview"
                                className="w-full h-full object-cover"
                            />
                            <div className="absolute inset-0 bg-black bg-opacity-40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center gap-2">
                                <label className="cursor-pointer bg-white text-gray-900 px-3 py-1.5 rounded-lg text-sm font-medium hover:bg-gray-100">
                                    Zmeniť
                                    <input type="file" className="hidden" accept="image/*" onChange={handleChange} />
                                </label>
                                <button
                                    onClick={() => onUploadSuccess('')}
                                    className="bg-red-600 text-white px-3 py-1.5 rounded-lg text-sm font-medium hover:bg-red-700"
                                >
                                    Odstrániť
                                </button>
                            </div>
                        </div>
                    </div>
                ) : (
                    <div className="p-10 text-center">
                        <PhotoIcon className="mx-auto h-12 w-12 text-gray-300" />
                        <div className="mt-4 flex text-sm leading-6 text-gray-600 justify-center">
                            <label className="relative cursor-pointer rounded-md bg-white font-semibold text-indigo-600 focus-within:outline-none focus-within:ring-2 focus-within:ring-indigo-600 focus-within:ring-offset-2 hover:text-indigo-500">
                                <span>Nahrať súbor</span>
                                <input type="file" className="sr-only" accept="image/*" onChange={handleChange} />
                            </label>
                            <p className="pl-1">alebo potiahnite sem</p>
                        </div>
                        <p className="text-xs leading-5 text-gray-500">PNG, JPG, WEBP do 5MB</p>
                    </div>
                )}

                {uploading && (
                    <div className="absolute inset-0 bg-white bg-opacity-80 flex flex-col items-center justify-center rounded-xl z-20">
                        <CloudArrowUpIcon className="w-10 h-10 text-indigo-600 animate-bounce" />
                        <p className="text-sm font-medium text-gray-700 mt-2">Nahrávam obrázok...</p>
                    </div>
                )}
            </div>

            <div className="flex items-center gap-2">
                <input
                    type="text"
                    value={currentImageUrl}
                    onChange={(e) => onUploadSuccess(e.target.value)}
                    className="w-full text-xs text-gray-400 border-none bg-transparent"
                    placeholder="Alebo vložte URL adresu..."
                />
            </div>
        </div>
    );
};

export default LegisBlogImageUpload;
