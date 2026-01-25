import React, { useState, useEffect, useRef } from 'react';
import { PencilIcon, PlusCircleIcon, ListBulletIcon, LinkIcon, Bars3CenterLeftIcon } from '@heroicons/react/24/outline';

const LegisBlogPreview = ({ post, lang, onUpdate, onImageEdit }) => {
    const [toolbarPos, setToolbarPos] = useState({ top: 0, left: 0, visible: false, type: 'selection' });
    const contentRef = useRef(null);
    const titleRef = useRef(null);
    const descRef = useRef(null);

    const title = post.translations?.[lang]?.title || '';
    const description = post.translations?.[lang]?.description || '';
    const content = post.translations?.[lang]?.content || '';
    const category = post.translations?.[lang]?.category || 'Kategória';
    const date = post.date || new Date().toLocaleDateString();
    const readingTime = post.translations?.[lang]?.reading_time || '5 min čítania';
    const image = post.image_url || '/sources/images/blog-1.jpg';

    // Sync initial content to refs
    useEffect(() => {
        if (titleRef.current && titleRef.current.innerText !== title) titleRef.current.innerText = title;
        if (descRef.current && descRef.current.innerText !== description) descRef.current.innerText = description;
        if (contentRef.current && contentRef.current.innerHTML !== content) {
            contentRef.current.innerHTML = content || '<p><br></p>';
        }
    }, [lang]); // Reset/Sync when language changes

    const execCommand = (command, val = null) => {
        document.execCommand(command, false, val);
        onUpdate('content', contentRef.current.innerHTML);
    };

    const handleSelection = () => {
        const selection = window.getSelection();
        if (!selection || selection.rangeCount === 0) return;

        const range = selection.getRangeAt(0);

        // Check if selection is inside the main content area
        if (!contentRef.current?.contains(range.commonAncestorContainer)) {
            setToolbarPos(prev => ({ ...prev, visible: false }));
            return;
        }

        if (!selection.isCollapsed) {
            const rect = range.getBoundingClientRect();
            setToolbarPos({
                top: rect.top + window.scrollY - 50,
                left: rect.left + window.scrollX + (rect.width / 2) - 80,
                visible: true,
                type: 'format'
            });
        } else {
            const node = selection.anchorNode;
            const element = node.nodeType === 3 ? node.parentElement : node;

            if (element && (element.innerText === '\n' || element.innerText === '' || element.innerHTML === '<br>')) {
                const rect = element.getBoundingClientRect();
                setToolbarPos({
                    top: rect.top + window.scrollY,
                    left: rect.left + window.scrollX - 40,
                    visible: true,
                    type: 'block'
                });
            } else {
                setToolbarPos(prev => ({ ...prev, visible: false }));
            }
        }
    };

    useEffect(() => {
        const events = ['mouseup', 'keyup', 'focus'];
        events.forEach(ev => document.addEventListener(ev, handleSelection));
        return () => events.forEach(ev => document.removeEventListener(ev, handleSelection));
    }, []);

    const tools = [
        { label: 'H2', icon: 'H2', action: () => execCommand('formatBlock', 'h2') },
        { label: 'H3', icon: 'H3', action: () => execCommand('formatBlock', 'h3') },
        { label: 'Odstavec', icon: <Bars3CenterLeftIcon className="w-4 h-4" />, action: () => execCommand('formatBlock', 'p') },
        { label: 'Tučné', icon: 'B', action: () => execCommand('bold') },
        { label: 'Kurzíva', icon: 'I', action: () => execCommand('italic') },
        { label: 'Zoznam', icon: <ListBulletIcon className="w-4 h-4" />, action: () => execCommand('insertUnorderedList') },
        {
            label: 'Odkaz', icon: <LinkIcon className="w-4 h-4" />, action: () => {
                const url = prompt('URL:');
                if (url) execCommand('createLink', url);
            }
        },
    ];

    return (
        <div className="legis-preview-container bg-white shadow-2xl overflow-visible min-h-screen">
            <style dangerouslySetInnerHTML={{
                __html: `
                .legis-preview-container {
                    --primary-color: #213753;
                    --primary-dark: #1b3a51;
                    --secondary-color: #ddedf9;
                    --light-blue: #e8f2ff;
                    --white: #ffffff;
                    --gray: #666666;
                    --dark-gray: #1a1b1f;
                    --border-light: rgba(33, 55, 83, 0.4);
                    --radius-xl: 16px;
                    --font-family-primary: 'DM Sans', sans-serif;
                    --font-family-serif: 'Crimson Text', serif;
                    font-family: var(--font-family-primary);
                }

                .post-header-preview {
                    padding: 4rem 2rem 0 2rem;
                    max-width: 1200px;
                    margin: 0;
                }

                .cat-badge {
                    background: var(--primary-color);
                    color: white;
                    padding: 4px 12px;
                    border-radius: 20px;
                    font-size: 0.75rem;
                    font-weight: bold;
                    letter-spacing: 0.05em;
                }

                .post-content-preview {
                    padding: 0 2rem 4rem 2rem;
                    max-width: 1200px;
                    margin: 0;
                }

                .content-rich-text-preview {
                    outline: none;
                }

                .content-rich-text-preview h2 {
                    color: var(--primary-color);
                    margin-top: 3rem;
                    margin-bottom: 0;
                    font-size: 2rem;
                    border-bottom: 2px solid var(--light-blue);
                    padding-bottom: 0.2rem;
                    font-family: var(--font-family-serif);
                    font-weight: 300;
                }

                .content-rich-text-preview h3 {
                    color: var(--primary-dark);
                    margin-top: 2rem;
                    margin-bottom: 0.2rem;
                    font-size: 1.5rem;
                    font-family: var(--font-family-serif);
                    font-weight: 300;
                }

                .content-rich-text-preview p {
                    color: var(--gray);
                    line-height: 1.6;
                    margin-bottom: 1.5rem;
                    font-size: 1rem;
                    font-weight: 300;
                }

                .content-rich-text-preview ul {
                    margin: 2rem 0;
                    padding-left: 2rem;
                    list-style-type: disc;
                }

                .hero-preview {
                    position: relative;
                    height: 30vh;
                    overflow: hidden;
                    width: 100%;
                }

                .hero-preview img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .image-edit-overlay {
                    position: absolute;
                    top: 2rem;
                    right: 2rem;
                    background: white;
                    padding: 1rem;
                    border-radius: 50%;
                    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
                    cursor: pointer;
                    z-index: 50;
                    transition: all 0.3s;
                }

                .image-edit-overlay:hover {
                    transform: scale(1.1);
                    background: var(--light-blue);
                }

                .floating-ui {
                    position: absolute;
                    z-index: 1000;
                }
                
                .format-toolbar {
                    display: flex;
                    gap: 2px;
                    background: #1e293b;
                    padding: 4px;
                    border-radius: 8px;
                    box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1);
                }
                
                .format-toolbar button {
                    color: white; width: 36px; height: 36px;
                    display: flex; align-items: center; justify-content: center;
                    border-radius: 4px; font-size: 13px; font-weight: bold;
                }
                
                .format-toolbar button:hover { background: #334155; color: #818cf8; }

                .editable-field {
                    outline: none;
                    transition: background 0.2s;
                    border-radius: 4px;
                }
                .editable-field:hover { background: rgba(0,0,0,0.02); }
                .editable-field:focus { background: white; }

                [contenteditable][placeholder]:empty:before {
                    content: attr(placeholder);
                    color: #cbd5e1;
                    cursor: text;
                }
            `}} />

            {/* Floating Toolbar */}
            {toolbarPos.visible && (
                <div
                    className="floating-ui"
                    style={{ top: toolbarPos.top, left: toolbarPos.left }}
                    onMouseDown={(e) => e.preventDefault()}
                >
                    {toolbarPos.type === 'format' ? (
                        <div className="format-toolbar">
                            {tools.map((tool, i) => (
                                <button key={i} type="button" onClick={tool.action} title={tool.label}>{tool.icon}</button>
                            ))}
                        </div>
                    ) : (
                        <div className="group relative">
                            <PlusCircleIcon className="w-8 h-8 text-indigo-400 opacity-50 hover:opacity-100 cursor-pointer" />
                            <div className="hidden group-hover:flex absolute left-10 top-0 format-toolbar">
                                {tools.filter(t => typeof t.icon === 'string' || t.label === 'Odstavec' || t.label === 'Zoznam').map((tool, i) => (
                                    <button key={i} type="button" onClick={tool.action} title={tool.label}>{tool.icon}</button>
                                ))}
                            </div>
                        </div>
                    )}
                </div>
            )}

            <div className="hero-preview">
                <img src={image} alt={title} />
                <button onClick={onImageEdit} className="image-edit-overlay" title="Zmeniť úvodný obrázok">
                    <PencilIcon className="w-6 h-6 text-indigo-600" />
                </button>
            </div>

            <div className="post-header-preview">
                <div className="flex items-center gap-4 mb-8">
                    <span className="cat-badge">{category}</span>
                    <span className="text-gray-400 text-sm">{date} • {readingTime}</span>
                </div>

                <h1
                    ref={titleRef}
                    contentEditable
                    onInput={(e) => onUpdate('title', e.target.innerText)}
                    className="editable-field text-[3rem] leading-tight font-serif text-[#213753] mb-4 font-light"
                    placeholder="Titulok článku..."
                />

                <p
                    ref={descRef}
                    contentEditable
                    onInput={(e) => onUpdate('description', e.target.innerText)}
                    className="editable-field text-[1.25rem] text-gray-500 italic leading-relaxed font-light"
                    placeholder="Krátky popis pre náhľad a SEO..."
                />
            </div>

            <div className="post-content-preview">
                <div
                    ref={contentRef}
                    contentEditable
                    onInput={(e) => onUpdate('content', e.target.innerHTML)}
                    className="content-rich-text-preview"
                    placeholder="Tu začnite písať hlavný obsah článku..."
                />
            </div>
        </div>
    );
};

export default LegisBlogPreview;
